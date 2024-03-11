import 'package:music_player_test/features/locale_musics/domain/entity/locale_musics_entity.dart';
import 'package:music_player_test/features/network_musics/data/model/model.dart';
import 'package:music_player_test/features/network_musics/domain/entity/entity.dart';
import 'package:music_player_test/features/playing_music/domain/entity/playing_music_entity.dart';

extension NetworkMusicsExtension on NetWorkMusicsModel {
  NetWorkMusicsEntity get toEntity {
    return NetWorkMusicsEntity(
      id: id,
      title: title,
      album: album,
      artist: artist,
      genre: genre,
      source: source,
      imgurl: image,
      trackNumber: trackNumber,
      totalTrackCount: totalTrackCount,
      duration: duration,
    );
  }
}

extension LocaleMusicsToNetWorkMusicsExtension on LocaleMusicsEntity {
  NetWorkMusicsEntity get localeToNetwork {
    return NetWorkMusicsEntity(
      id: id,
      title: title,
      album: album,
      artist: artist,
      genre: genre,
      source: source,
      imgurl: imgurl,
      trackNumber: trackNumber,
      totalTrackCount: totalTrackCount,
      duration: duration,
    );
  }
}

extension PlayingMusicEntityExtension on NetWorkMusicsEntity {
  PlayingMusicEntity get toPlayingMusicEntity {
    return PlayingMusicEntity(
      id: id,
      title: title,
      artist: artist,
      source: source,
      imgurl: imgurl,
      trackNumber: trackNumber,
      totalTrackCount: totalTrackCount,
      duration: duration,
      album: '',
      genre: '',
      localMusicUrl: '',
    );
  }
}
