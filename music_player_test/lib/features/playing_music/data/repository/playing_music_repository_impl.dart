import 'package:music_player_test/core/either/either.dart';
import 'package:music_player_test/core/failure/failure.dart';
import 'package:music_player_test/features/network_musics/domain/entity/entity.dart';
import 'package:music_player_test/features/playing_music/data/data_source/playing_music_data_source.dart';
import 'package:music_player_test/features/playing_music/domain/entity/playing_music_entity.dart';
import 'package:music_player_test/features/playing_music/domain/repository/playing_music_repository.dart';

class PlayingMusicRepositoryImpl implements PlayingMusicRepository {
  final PlayingMusicDataSource dataSource;

  PlayingMusicRepositoryImpl({required this.dataSource});

  @override
  Either<ServerFailure, PlayingMusicEntity> sortMusicEntity(
      {required NetWorkMusicsEntity thismusic}) {
    try {
      final music = dataSource.sortMusicEntity(music: thismusic);
      return Right(music);
    } catch (e) {
      return Left(const ServerFailure(message: "Malumotlar olinmadi"));
    }
  }

  @override
  Future<Either<ServerFailure, bool>> addMusic(
      {required PlayingMusicEntity music}) async {
    try {
      return Right(await dataSource.addMusic(music: music));
    } catch (e) {
      return Left(
        const ServerFailure(
          message: "Malumotni qo'shib bo'lmadi",
          code: 387,
        ),
      );
    }
  }
}
