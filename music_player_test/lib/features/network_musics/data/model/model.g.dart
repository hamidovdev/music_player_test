// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetWorkMusicsModel _$PlayerModelFromJson(Map<String, dynamic> json) =>
    NetWorkMusicsModel(
      id: json['id'] as String,
      title: json['title'] as String,
      album: json['album'] as String,
      artist: json['artist'] as String,
      genre: json['genre'] as String,
      source: json['source'] as String,
      image: json['image'] as String,
      trackNumber: json['trackNumber'] as int,
      totalTrackCount: json['totalTrackCount'] as int,
      duration: json['duration'] as int,
      site: json['site'] as String,
    );

Map<String, dynamic> _$PlayerModelToJson(NetWorkMusicsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'album': instance.album,
      'artist': instance.artist,
      'genre': instance.genre,
      'source': instance.source,
      'image': instance.image,
      'trackNumber': instance.trackNumber,
      'totalTrackCount': instance.totalTrackCount,
      'duration': instance.duration,
      'site': instance.site,
    };
