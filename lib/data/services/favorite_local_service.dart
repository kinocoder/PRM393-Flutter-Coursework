import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sql.dart';
import 'package:hoc_tren_truong/data/local/app_database.dart';

import '../model/photo_api_model.dart';

part 'favorite_local_service.g.dart';

@Riverpod(keepAlive: true)
FavoriteLocalService favoriteLocalService(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return FavoriteLocalService(database);
}

class FavoriteLocalService {
  final AppDatabase _appDatabase;

  FavoriteLocalService(this._appDatabase);

  //Thêm ảnh vào danh sách yêu thích
  Future<int> insertFavorite(PhotoApiModel photo) async {
    final db = await _appDatabase.database;

    return db.insert(
      'favorite_photo',
      photo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  //Lấy danh sách ảnh yêu thích
  Future<List<PhotoApiModel>> getPhotos() async {
    final db = await _appDatabase.database;

    final List<Map<String, Object?>> maps = await db.query('favorite_photo');

    return maps.map((map) {
      return PhotoApiModel.fromMap(map);
    }).toList();
  }

  //Kiểm tra xem ảnh có tồn tại không
  Future<bool> isFavoritePhoto(int photoId) async{
    final db = await _appDatabase.database;
    final maps = await db.query(
      'favorite_photo',
      columns: ['photo_id'],
      where: 'photo_id = ?',
      whereArgs: [photoId],
      limit: 1
    );

    return maps.isNotEmpty;
  }

  //Xóa ảnh yêu thích ra khỏi danh sách
  Future<int> deleteFavoritePhoto(int photoId) async {
    final db = await _appDatabase.database;

    return db.delete(
      'favorite_photo',
      where: 'photo_id = ?',
      whereArgs: [photoId],
    );
  }


}
