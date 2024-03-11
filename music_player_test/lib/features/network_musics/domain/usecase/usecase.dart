import 'package:music_player_test/core/either/either.dart';
import 'package:music_player_test/core/failure/failure.dart';
import 'package:music_player_test/core/useCase/usecase.dart';
import 'package:music_player_test/features/network_musics/data/repository/repository_impl.dart';
import 'package:music_player_test/features/network_musics/domain/entity/entity.dart';

class NetWorkMusicsUseCase
    implements UseCase<List<NetWorkMusicsEntity>, NoParams> {
  final NetWorkMusicsRepositoryImpl repositoryImpl;

  NetWorkMusicsUseCase({required this.repositoryImpl});
  @override
  Future<Either<Failure, List<NetWorkMusicsEntity>>> call(
    NoParams params,
  ) async {
    return await repositoryImpl.getMusics();
  }
}
