import 'package:dio/dio.dart';
import 'package:music_player_test/core/exception/exception.dart';
import 'package:music_player_test/core/extension/to_entity_extensions.dart';
import 'package:music_player_test/features/network_musics/data/model/model.dart';
import 'package:music_player_test/features/network_musics/domain/entity/entity.dart';

abstract class MusicPlayerDataSource {
  factory MusicPlayerDataSource() => _MusicPlayerDataSourceImpl();

  Future<List<NetWorkMusicsEntity>> getMusics();
}

class _MusicPlayerDataSourceImpl implements MusicPlayerDataSource {
  @override
  Future<List<NetWorkMusicsEntity>> getMusics() async {
    try {
      final dio = Dio();
      final resp =
          await dio.get("https://storage.googleapis.com/uamp/catalog.json");
      final datas = resp.data["music"];
      final musics = (datas as List)
          .map((data) => NetWorkMusicsModel.fromJson(data))
          .toList();
      return musics.map((datas) => datas.toEntity).toList();
    } catch (e) {
      throw ServerException(
        errorMessage: "Datasource da xatolik",
        errorCode: "333",
      );
    }
  }
}
