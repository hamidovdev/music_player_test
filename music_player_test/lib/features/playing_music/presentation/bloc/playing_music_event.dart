part of 'playing_music_bloc.dart';

abstract class PlayingMusicEvent {}

class GetMusic extends PlayingMusicEvent {
  final NetWorkMusicsEntity music;
  final int index;
  final List<NetWorkMusicsEntity>? musics;
  GetMusic({required this.music, required this.index, this.musics});
}

class AddFunctions extends PlayingMusicEvent {}

class IsPlay extends PlayingMusicEvent {}

class DownloadMusic extends PlayingMusicEvent {
  final String url;
  final String id;
  final Callback success;
  DownloadMusic({
    required this.url,
    required this.id,
    required this.success,
  });
}

class AddLocalMusic extends PlayingMusicEvent {
  final PlayingMusicEntity music;

  AddLocalMusic({required this.music});
}

class EditIndex extends PlayingMusicEvent {
  final String? calc;
  final AudioPlayer player;
  final bool isFinished;
  EditIndex({
    required this.player,
    this.calc,
    required this.isFinished,
  });
}

class EditDuration extends PlayingMusicEvent {
  final int minute;
  final int second;
  final VoidCallback success;

  EditDuration(
      {required this.minute, required this.second, required this.success});
}

class ReplacePage extends PlayingMusicEvent {}
