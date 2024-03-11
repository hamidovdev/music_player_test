import 'package:music_player_test/core/either/either.dart';
import 'package:music_player_test/core/failure/failure.dart';
import 'package:music_player_test/features/network_musics/domain/entity/entity.dart';

abstract class MusicPlayerRepository {
  Future<Either<ServerFailure, List<NetWorkMusicsEntity>>> getMusics();
}
