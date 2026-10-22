import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final appDatabase = AppDatabase();

  ref.onDispose(() {
    appDatabase.close();
  });

  return appDatabase;
}

class AppDatabase {
  Future<Database>? _database;

  Future<Database> get database {
    return _database ??= _openDatabase();
  }

  //Phương thức mở database
  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE favorite_photos(
          photo_id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          url TEXT NOT NULL,
          thumbnail_url TEXT NOT NULL
          )
          """);
      },
    );
  }

  Future<void> close() async {
    final future = _database;
    if (future != null) {
      final db = await future;
      await db.close();
      _database = null;
    }
  }
}
