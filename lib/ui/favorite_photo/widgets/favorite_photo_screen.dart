import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hoc_tren_truong/ui/favorite_photo/view_models/favorite_photo_view_model.dart';

import '../../core/ui/photo_card.dart';

class FavoritePhotoView extends ConsumerWidget {
  const FavoritePhotoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoAsync = ref.watch(favoritePhotoViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Photo Wish List')),
      body: photoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Không thể tải ảnh: $error')),
        data: (photos) {
          if (photos.isEmpty) {
            return const Center(child: Text('chưa có ảnh '));
          }
          return ListView.builder(
            itemCount: photos.length,
            itemBuilder: (contex, index) {
              final photo = photos[index];

              return PhotoCard(
                key: ValueKey(photo.photoId),
                photo: photo,
                isFavorite: true,
                onFavoritePress: () {
                  ref
                      .read(favoritePhotoViewModelProvider.notifier)
                      .deleteFavoritePhoto(photo.photoId);
                },
              );
            },
          );
        },
      ),
    );
  }
}
