import 'package:music_player_test/core/either/either.dart';
import 'package:music_player_test/core/failure/failure.dart';
import 'package:music_player_test/core/useCase/usecase.dart';
import 'package:music_player_test/features/locale_musics/data/repository/locale_music_repositoryimpl.dart';
import 'package:music_player_test/features/locale_musics/domain/entity/locale_musics_entity.dart';

class LocaleMusicsGetUseCase
    implements UseCase<List<LocaleMusicsEntity>, NoParams> {
  final LocaleMusicsRepositoryImpl repositoryImpl;

  LocaleMusicsGetUseCase({required this.repositoryImpl});
  @override
  Future<Either<Failure, List<LocaleMusicsEntity>>> call(
    NoParams params,
  ) async {
    return await repositoryImpl.getLocalMusics();
  }
}
