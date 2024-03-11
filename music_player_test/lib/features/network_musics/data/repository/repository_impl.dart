import 'package:music_player_test/core/either/either.dart';
import 'package:music_player_test/core/failure/failure.dart';
import 'package:music_player_test/features/network_musics/data/data_source/data_source.dart';
import 'package:music_player_test/features/network_musics/domain/entity/entity.dart';
import 'package:music_player_test/features/network_musics/domain/repository/repository.dart';

class NetWorkMusicsRepositoryImpl implements MusicPlayerRepository {
  final MusicPlayerDataSource dataSource;

  NetWorkMusicsRepositoryImpl({required this.dataSource});
  @override
  Future<Either<ServerFailure, List<NetWorkMusicsEntity>>> getMusics() async {
    try {
      final musics = await dataSource.getMusics();
      return Right(musics);
    } catch (e) {
      return Left(ServerFailure(message: "Malumotlar olinmadi"));
    }
  }
}
