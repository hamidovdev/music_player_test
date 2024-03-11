import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class NetWorkMusicsModel {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "album")
  String album;
  @JsonKey(name: "artist")
  String artist;
  @JsonKey(name: "genre")
  String genre;
  @JsonKey(name: "source")
  String source;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "trackNumber")
  int trackNumber;
  @JsonKey(name: "totalTrackCount")
  int totalTrackCount;
  @JsonKey(name: "duration")
  int duration;
  @JsonKey(name: "site")
  String site;

  NetWorkMusicsModel({
    required this.id,
    required this.title,
    required this.album,
    required this.artist,
    required this.genre,
    required this.source,
    required this.image,
    required this.trackNumber,
    required this.totalTrackCount,
    required this.duration,
    required this.site,
  });

  factory NetWorkMusicsModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}
