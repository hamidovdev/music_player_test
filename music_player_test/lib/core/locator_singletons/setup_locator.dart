import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseRepository {
  DataBaseRepository._();
  static DataBaseRepository? _dataBaseRepository;
  static Database? _database;

  static Future<DataBaseRepository> getInstance() async {
    if (_dataBaseRepository == null) {
      final storage = DataBaseRepository._();
      await storage.init();
      _dataBaseRepository = storage;
    }
    return _dataBaseRepository!;
  }

  Future<Database> init() async {
    return await initDatabase();
  }

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'musics_databse.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS my_musics_table (id INTEGER, title TEXT, album TEXT, artist TEXT, genre TEXT, source TEXT, image TEXT, trackNumber INTEGER, totalTrackCount INTEGER, duration INTEGER, localPathUrl TEXT)',
        );
      },
    );
  }
}
