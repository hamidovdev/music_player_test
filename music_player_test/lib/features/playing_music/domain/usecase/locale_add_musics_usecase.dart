import 'package:music_player_test/core/either/either.dart';
import 'package:music_player_test/core/failure/failure.dart';
import 'package:music_player_test/core/useCase/usecase.dart';
import 'package:music_player_test/features/playing_music/data/repository/playing_music_repository_impl.dart';
import 'package:music_player_test/features/playing_music/domain/entity/playing_music_entity.dart';

class AddLocaleMusicsUseCase implements UseCase<bool, NoParams> {
  final PlayingMusicRepositoryImpl repositoryImpl;

  AddLocaleMusicsUseCase({required this.repositoryImpl});

  @override
  Future<Either<Failure, bool>> call(params,
      {PlayingMusicEntity? music}) async {
    return await repositoryImpl.addMusic(music: music!);
  }
}
