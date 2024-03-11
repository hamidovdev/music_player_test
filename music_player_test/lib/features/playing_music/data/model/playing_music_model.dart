import 'package:music_player_test/features/playing_music/domain/entity/playing_music_entity.dart';

class PlayingMusicModel extends PlayingMusicEntity {
  PlayingMusicModel({
    required super.id,
    required super.title,
    required super.artist,
    required super.source,
    required super.imgurl,
    required super.trackNumber,
    required super.totalTrackCount,
    required super.duration,
    required super.album,
    required super.genre,
    required super.localMusicUrl,
  });
}
