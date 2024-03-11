part of 'locale_musics_bloc.dart';

class LocaleMusicsState {
  final Status status;
  final List<LocaleMusicsEntity> musics;

  LocaleMusicsState({
    required this.status,
    required this.musics,
  });

  LocaleMusicsState copyWith({
    Status? status,
    List<LocaleMusicsEntity>? musics,
  }) {
    return LocaleMusicsState(
      status: status ?? this.status,
      musics: musics ?? this.musics,
    );
  }

  @override
  bool operator ==(covariant LocaleMusicsState other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.musics, musics);
  }

  @override
  int get hashCode => status.hashCode ^ musics.hashCode;
}
