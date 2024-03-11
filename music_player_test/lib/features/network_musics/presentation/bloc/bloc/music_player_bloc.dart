import 'package:bloc/bloc.dart';
import 'package:music_player_test/core/failure/failure.dart';
import 'package:music_player_test/core/app_status/main_status.dart';
import 'package:music_player_test/core/useCase/usecase.dart';
import 'package:music_player_test/features/network_musics/data/data_source/data_source.dart';
import 'package:music_player_test/features/network_musics/data/repository/repository_impl.dart';
import 'package:music_player_test/features/network_musics/domain/entity/entity.dart';
import 'package:music_player_test/features/network_musics/domain/usecase/usecase.dart';
import 'package:flutter/foundation.dart';

part 'music_player_event.dart';
part 'music_player_state.dart';

class NetWorkMusicsBloc extends Bloc<NetWorkMusicsEvent, NetWorkMusicsState> {
  NetWorkMusicsBloc()
      : super(NetWorkMusicsState(
          musics: [],
          status: Status.none,
        )) {
    on<GetMusics>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final usecase = NetWorkMusicsUseCase(
        repositoryImpl: NetWorkMusicsRepositoryImpl(
          dataSource: MusicPlayerDataSource(),
        ),
      );

      final either = await usecase.call(NoParams());
      either.either((failure) {
        emit(state.copyWith(status: Status.failure));
        const ServerFailure(code: 304, message: "Xatolik bor");
      }, (value) {
        emit(
          state.copyWith(
            status: Status.success,
            musics: value,
          ),
        );
      });
    });
  }
}
