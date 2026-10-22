import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/photo_view_model.dart';
import '../widgets/photo_card.dart';

class PhotoView extends ConsumerWidget {
  const PhotoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoAsync = ref.watch(photoViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Photo')),
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

              return PhotoCard(key: ValueKey(photo.photoId), photo: photo);
            },
          );
        },
      ),
    );
  }
}
