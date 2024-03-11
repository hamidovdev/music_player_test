import 'package:bloc/bloc.dart';
import 'package:music_player_test/core/app_status/main_status.dart';
import 'package:music_player_test/core/useCase/usecase.dart';
import 'package:music_player_test/features/locale_musics/data/data_source/locale_musics_data_source.dart';
import 'package:music_player_test/features/locale_musics/data/repository/locale_music_repositoryimpl.dart';
import 'package:music_player_test/features/locale_musics/domain/entity/locale_musics_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:music_player_test/features/locale_musics/domain/usecase/locale_get_musics_usecase.dart';
part 'locale_musics_event.dart';
part 'locale_musics_state.dart';

class LocaleMusicsBloc extends Bloc<LocaleMusicsEvent, LocaleMusicsState> {
  LocaleMusicsBloc()
      : super(LocaleMusicsState(musics: [], status: Status.none)) {
    on<GetLocalMusics>((event, emit) async {
      emit(state.copyWith(status: Status.loading, musics: []));
      final usecase = LocaleMusicsGetUseCase(
        repositoryImpl: LocaleMusicsRepositoryImpl(
          dataSource: LocaleMusicsDataSource(),
        ),
      );
      final either = await usecase.call(NoParams());
      either.either((failure) {
        emit(state.copyWith(status: Status.success));
      }, (value) {
        emit(state.copyWith(status: Status.success, musics: value));
      });
    });
  }
}
