import 'package:music_player_test/core/either/either.dart';
import 'package:music_player_test/core/failure/failure.dart';
import 'package:music_player_test/features/network_musics/domain/entity/entity.dart';
import 'package:music_player_test/features/playing_music/domain/entity/playing_music_entity.dart';

abstract class PlayingMusicRepository {
  Either<ServerFailure, PlayingMusicEntity> sortMusicEntity({
    required NetWorkMusicsEntity thismusic,
  });
  Future<Either<ServerFailure, bool>> addMusic({
    required PlayingMusicEntity music,
  });
}
