class NetWorkMusicsEntity {
  final String id;
  final String title;
  final String album;
  final String artist;
  final String genre;
  final String source;
  final String imgurl;
  final int trackNumber;
  final int totalTrackCount;
  final int duration;

  NetWorkMusicsEntity({
    required this.id,
    required this.title,
    required this.album,
    required this.artist,
    required this.genre,
    required this.source,
    required this.imgurl,
    required this.trackNumber,
    required this.totalTrackCount,
    required this.duration,
  });

  @override
  String toString() {
    return 'MusicPlayerEntity(id: $id, title: $title, album: $album, artist: $artist, genre: $genre, source: $source, imgurl: $imgurl, trackNumber: $trackNumber, totalTrackCount: $totalTrackCount, duration: $duration)';
  }

  @override
  bool operator ==(covariant NetWorkMusicsEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.album == album &&
        other.artist == artist &&
        other.genre == genre &&
        other.source == source &&
        other.imgurl == imgurl &&
        other.trackNumber == trackNumber &&
        other.totalTrackCount == totalTrackCount &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        album.hashCode ^
        artist.hashCode ^
        genre.hashCode ^
        source.hashCode ^
        imgurl.hashCode ^
        trackNumber.hashCode ^
        totalTrackCount.hashCode ^
        duration.hashCode;
  }
}
