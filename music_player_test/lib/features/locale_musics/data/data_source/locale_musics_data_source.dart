import 'package:music_player_test/core/exception/exception.dart';
import 'package:music_player_test/core/locator_singletons/setup_locator.dart';
import 'package:music_player_test/features/locale_musics/domain/entity/locale_musics_entity.dart';

abstract class LocaleMusicsDataSource {
  factory LocaleMusicsDataSource() => _MusicPlayerDataSourceImpl();
  Future<List<LocaleMusicsEntity>> getLocaleMusics();
}

class _MusicPlayerDataSourceImpl implements LocaleMusicsDataSource {
  @override
  Future<List<LocaleMusicsEntity>> getLocaleMusics() async {
    try {
      DataBaseRepository db = await DataBaseRepository.getInstance();
      final initing = await db.init();
      final mapDatas = await initing.query("my_musics_table");
      List<LocaleMusicsEntity> datas = [];
      for (Map<String, dynamic> data in mapDatas) {
        datas.add(
          LocaleMusicsEntity(
            id: data["id"],
            title: data["title"],
            album: data["album"],
            artist: data["artist"],
            genre: data["genre"],
            source: data["source"],
            imgurl: data["image"],
            trackNumber: data["trackNumber"],
            totalTrackCount: data["totalTrackCount"],
            duration: data["duration"],
            localMusicUrl: data["localPathUrl"],
          ),
        );
      }
      return datas;
    } catch (e) {
      throw ServerException(
        errorMessage: "Malumotlar local xotiradan olinmadi",
        errorCode: "300",
      );
    }
  }
}
