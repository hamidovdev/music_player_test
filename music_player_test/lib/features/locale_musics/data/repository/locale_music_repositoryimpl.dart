import 'package:music_player_test/core/either/either.dart';
import 'package:music_player_test/core/failure/failure.dart';
import 'package:music_player_test/features/locale_musics/data/data_source/locale_musics_data_source.dart';
import 'package:music_player_test/features/locale_musics/domain/entity/locale_musics_entity.dart';
import 'package:music_player_test/features/locale_musics/domain/repository/locale_musics_repository.dart';

class LocaleMusicsRepositoryImpl implements LocaleMusicsRepository {
  final LocaleMusicsDataSource dataSource;

  LocaleMusicsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<ServerFailure, List<LocaleMusicsEntity>>>
      getLocalMusics() async {
    try {
      final datas = await dataSource.getLocaleMusics();
      return Right(datas);
    } catch (e) {
      return Left(
        const ServerFailure(
          message: "Malumotni olib bo'lmadi",
          code: 404,
        ),
      );
    }
  }
}
