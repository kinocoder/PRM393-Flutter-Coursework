import 'package:hoc_tren_truong/data/model/photo_api_model.dart';
import 'package:hoc_tren_truong/data/services/photo_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_repository.g.dart';

@riverpod
PhotoRepository photoRepository(Ref ref) {
  return PhotoRepository();
}

class PhotoRepository {
  Future<List<PhotoApiModel>> getPhotos() {
    return fetchPhotos();
  }
}
