import 'package:music_player_test/features/locale_musics/domain/entity/locale_musics_entity.dart';

class LocaleMusicsModel extends LocaleMusicsEntity {
  LocaleMusicsModel({
    required super.id,
    required super.title,
    required super.album,
    required super.artist,
    required super.genre,
    required super.source,
    required super.imgurl,
    required super.trackNumber,
    required super.totalTrackCount,
    required super.duration,
    required super.localMusicUrl,
  });
}
