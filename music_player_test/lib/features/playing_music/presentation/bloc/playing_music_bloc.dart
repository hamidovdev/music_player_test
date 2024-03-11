import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_test/core/app_status/main_status.dart';
import 'package:music_player_test/core/app_status/player_functions.dart';
import 'package:music_player_test/core/either/either.dart';
import 'package:music_player_test/core/extension/to_entity_extensions.dart';
import 'package:music_player_test/core/useCase/usecase.dart';
import 'package:music_player_test/features/network_musics/domain/entity/entity.dart';
import 'package:music_player_test/features/playing_music/data/data_source/playing_music_data_source.dart';
import 'package:music_player_test/features/playing_music/data/repository/playing_music_repository_impl.dart';
import 'package:music_player_test/features/playing_music/domain/entity/playing_music_entity.dart';
import 'package:music_player_test/features/playing_music/domain/usecase/locale_add_musics_usecase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'playing_music_event.dart';
part 'playing_music_state.dart';

class PlayingMusicBloc extends Bloc<PlayingMusicEvent, PlayingMusicState> {
  PlayingMusicBloc()
      : super(PlayingMusicState(
            ind: 0,
            isPlay: false,
            status: Status.none,
            musics: [],
            durationData: "",
            part: 0,
            downloadingNumbers: 0)) {
    on<GetMusic>((event, emit) {
      final either =
          PlayingMusicRepositoryImpl(dataSource: PlayingMusicDataSource())
              .sortMusicEntity(thismusic: event.music);

      either.either((failure) {
        emit(state.copyWith(
          status: Status.failure,
        ));
      }, (value) async {
        final instanse = await SharedPreferences.getInstance();
        final function = instanse.getString("function");
        emit(
          state.copyWith(
            status: Status.success,
            music: value,
            ind: event.index,
            isPlay: false,
            musics: event.musics,
            functions: function == "repeatAll"
                ? Functions.repeatAll
                : (function == "repeatThis"
                    ? Functions.repeatThis
                    : Functions.shuffle),
          ),
        );
      });
    });
    on<EditIndex>((event, emit) async {
      int i = state.ind;
      final instanse = await SharedPreferences.getInstance();
      final function = instanse.getString("function");
      if (function == "shuffle") {
        i = (Random().nextInt(state.musics.length) - 1);
      } else if (function == "repeatThis" && event.isFinished) {
      } else {
        if (event.isFinished) {
          if (i + 1 == state.musics.length) {
            i = 0;
          } else {
            i += 1;
          }
        } else {
          if (event.calc == "+") {
            if (i + 1 == state.musics.length) {
              i = 0;
            } else {
              i += 1;
            }
          } else {
            if (i - 1 < 0) {
              i = state.musics.length - 1;
            } else {
              i -= 1;
            }
          }
        }
      }
      emit(state.copyWith(
        ind: i,
        musics: state.musics,
        status: Status.success,
        music: state.musics[i].toPlayingMusicEntity,
      ));
      await event.player.setUrl(state.music!.source);
      event.player.play();
    });
    on<IsPlay>((event, emit) {
      emit(
        state.copyWith(
          isPlay: state.isPlay ? false : true,
        ),
      );
    });
    on<AddFunctions>((event, emit) async {
      final instanse = await SharedPreferences.getInstance();
      final function = instanse.getString("function");
      if (function == "repeatAll") {
        await instanse.setString("function", "repeatThis");
      } else if (function == "repeatThis") {
        await instanse.setString("function", "shuffle");
      } else {
        await instanse.setString("function", "repeatAll");
      }
      final functiontwo = instanse.getString("function");
      emit(
        state.copyWith(
          functions: functiontwo == "repeatAll"
              ? Functions.repeatAll
              : (functiontwo == "repeatThis"
                  ? Functions.repeatThis
                  : Functions.shuffle),
        ),
      );
    });
    on<DownloadMusic>((event, emit) async {
      final dio = Dio();
      final dr = await getApplicationDocumentsDirectory();
      final formatIndex = event.url.lastIndexOf(".") + 1;
      final format = event.url.substring(formatIndex);
      final path = "${dr.path}/${event.id}.${format}";
      emit(state.copyWith(
        status: Status.downloading,
      ));
      await dio.download(
        event.url,
        path,
        onReceiveProgress: (count, total) {
          int p = (count / (total / 100)).toInt();
          if (p == count.toInt()) {
            emit(state.copyWith(downloadingNumbers: p));
          }
        },
      );
      final sharedIns = await SharedPreferences.getInstance();
      sharedIns.setBool(state.music!.id, true);
      emit(state.copyWith(status: Status.success));
      event.success(path);
    });
    on<AddLocalMusic>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final usecase = AddLocaleMusicsUseCase(
        repositoryImpl: PlayingMusicRepositoryImpl(
          dataSource: PlayingMusicDataSource(),
        ),
      );
      final either = await usecase.call(NoParams(), music: event.music);
      either.either((failure) {
        emit(state.copyWith(status: Status.success));
      }, (value) {
        emit(state.copyWith(status: Status.success));
      });
    });
    on<EditDuration>((event, emit) {
      if (state.music!.duration == event.second) {
        event.success();
      } else {
        String stepOne =
            "${event.minute >= 10 ? event.minute : "0${event.minute}"}:${event.second % 60 >= 10 ? event.second % 60 : "0${event.second % 60}"}";
        emit(
          state.copyWith(
            durationData: stepOne,
            part: event.second.toDouble(),
          ),
        );
      }
    });
    on<ReplacePage>((event, emit) {
      emit(state.copyWith(status: Status.none));
    });
  }
}
