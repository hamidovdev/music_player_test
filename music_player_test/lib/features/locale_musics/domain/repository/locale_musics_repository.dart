import 'package:music_player_test/core/either/either.dart';
import 'package:music_player_test/core/failure/failure.dart';
import 'package:music_player_test/features/locale_musics/domain/entity/locale_musics_entity.dart';

abstract class LocaleMusicsRepository {
  Future<Either<ServerFailure, List<LocaleMusicsEntity>>> getLocalMusics();
}
