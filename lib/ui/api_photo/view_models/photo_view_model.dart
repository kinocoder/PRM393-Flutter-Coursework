import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hoc_tren_truong/data/model/photo_api_model.dart';
import 'package:hoc_tren_truong/data/repositories/photo_repository.dart';

part 'photo_view_model.g.dart';

@riverpod
class PhotoViewModel extends _$PhotoViewModel {
  @override
  Future<List<PhotoApiModel>> build() async {
    final repo = ref.watch(photoRepositoryProvider);
    return await repo.getPhotos();
  }
}