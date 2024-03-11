part of 'music_player_bloc.dart';

class NetWorkMusicsState {
  final Status status;
  final List<NetWorkMusicsEntity> musics;

  NetWorkMusicsState({required this.status, required this.musics});

  NetWorkMusicsState copyWith({
    Status? status,
    List<NetWorkMusicsEntity>? musics,
  }) {
    return NetWorkMusicsState(
      status: status ?? this.status,
      musics: musics ?? this.musics,
    );
  }

  @override
  bool operator ==(covariant NetWorkMusicsState other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.musics, musics);
  }

  @override
  int get hashCode => status.hashCode ^ musics.hashCode;
}
