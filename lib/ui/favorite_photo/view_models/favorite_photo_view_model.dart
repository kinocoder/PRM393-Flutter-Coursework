
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/model/photo_api_model.dart';
import '../../../data/repositories/favorite_photo_repository.dart';

part 'favorite_photo_view_model.g.dart';

@riverpod
class FavoritePhotoViewModel extends _$FavoritePhotoViewModel {
  @override
  Future<List<PhotoApiModel>> build() async {
    final repository = ref.watch(favoritePhotoRepositoryProvider);

    return repository.getPhotosFavorite();
  }

  //Thêm ảnh
  Future<void> addFavoritePhoto(PhotoApiModel photo) async {
    if (state.isLoading) return;

    final repository = ref.read(favoritePhotoRepositoryProvider);
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      await repository.addFavorite(photo);
      return repository.getPhotosFavorite();
    });

    if (!ref.mounted) return;
    state = result;
  }

  //xóa ảnh
  Future<void> deleteFavoritePhoto(int photo) async {
    final repository = ref.read(favoritePhotoRepositoryProvider);
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      await repository.deleteFavoritePhoto(photo);
      return repository.getPhotosFavorite();
    });

    if (!ref.mounted) return;
    state = result;
  }
}
