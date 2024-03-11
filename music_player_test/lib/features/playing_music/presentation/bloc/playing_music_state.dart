part of 'playing_music_bloc.dart';

class PlayingMusicState {
  final Status status;
  final int ind;
  final PlayingMusicEntity? music;
  final List<NetWorkMusicsEntity> musics;
  final bool isPlay;
  final String durationData;
  final double part;
  final Functions? functions;
  final int? downloadingNumbers;

  PlayingMusicState({
    required this.status,
    required this.ind,
    this.music,
    required this.musics,
    required this.isPlay,
    required this.durationData,
    required this.part,
    this.functions,
    this.downloadingNumbers,
  });

  PlayingMusicState copyWith({
    Status? status,
    int? ind,
    PlayingMusicEntity? music,
    List<NetWorkMusicsEntity>? musics,
    bool? isPlay,
    String? durationData,
    double? part,
    Functions? functions,
    int? downloadingNumbers,
  }) {
    return PlayingMusicState(
      status: status ?? this.status,
      ind: ind ?? this.ind,
      music: music ?? this.music,
      musics: musics ?? this.musics,
      isPlay: isPlay ?? this.isPlay,
      durationData: durationData ?? this.durationData,
      part: part ?? this.part,
      functions: functions ?? this.functions,
      downloadingNumbers: downloadingNumbers ?? this.downloadingNumbers,
    );
  }

  @override
  bool operator ==(covariant PlayingMusicState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.ind == ind &&
        other.music == music &&
        listEquals(other.musics, musics) &&
        other.isPlay == isPlay &&
        other.durationData == durationData &&
        other.part == part &&
        other.functions == functions &&
        other.downloadingNumbers == downloadingNumbers;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        ind.hashCode ^
        music.hashCode ^
        musics.hashCode ^
        isPlay.hashCode ^
        durationData.hashCode ^
        part.hashCode ^
        functions.hashCode ^
        downloadingNumbers.hashCode;
  }
}
