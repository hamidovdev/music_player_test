import 'package:music_player_test/core/exception/exception.dart';
import 'package:music_player_test/core/extension/to_entity_extensions.dart';
import 'package:music_player_test/core/failure/failure.dart';
import 'package:music_player_test/core/locator_singletons/setup_locator.dart';
import 'package:music_player_test/features/network_musics/domain/entity/entity.dart';
import 'package:music_player_test/features/playing_music/domain/entity/playing_music_entity.dart';
import 'package:path_provider/path_provider.dart';

abstract class PlayingMusicDataSource {
  factory PlayingMusicDataSource() => _PlayingMusicDataSource();

  PlayingMusicEntity sortMusicEntity({
    required NetWorkMusicsEntity music,
  });
  Future<bool> addMusic({required PlayingMusicEntity music});
}

class _PlayingMusicDataSource implements PlayingMusicDataSource {
  @override
  PlayingMusicEntity sortMusicEntity({required NetWorkMusicsEntity music}) {
    try {
      return music.toPlayingMusicEntity;
    } catch (e) {
      throw ServerException(
        errorMessage: "Datasource da xatolik",
        errorCode: "333",
      );
    }
  }

  @override
  Future<bool> addMusic({required PlayingMusicEntity music}) async {
    try {
      DataBaseRepository db = await DataBaseRepository.getInstance();
      final dr = await getApplicationDocumentsDirectory();
      final formatIndex = music.source.lastIndexOf(".") + 1;
      final format = music.source.substring(formatIndex);
      final path = "${dr.path}/${music.id}.${format}";
      final dataBase = await db.init();
      await dataBase.insert("my_musics_table", {
        "id": music.id,
        "title": music.title,
        "album": music.album,
        "artist": music.artist,
        "genre": music.genre,
        "source": music.source,
        "image": music.imgurl,
        "trackNumber": music.trackNumber,
        "totalTrackCount": music.totalTrackCount,
        "duration": music.duration,
        "localPathUrl": path
      });
      return true;
    } catch (e) {
      throw const ServerFailure(
          message: "Malumotni qo'shib bo'lmadi", code: 388);
    }
  }
}
