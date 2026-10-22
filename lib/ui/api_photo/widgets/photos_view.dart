import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoc_tren_truong/ui/favorite_photo/view_models/favorite_photo_view_model.dart';

import '../view_models/photo_view_model.dart';
import '../../core/ui/photo_card.dart';

class PhotoView extends ConsumerWidget {
  const PhotoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoAsync = ref.watch(photoViewModelProvider);
    final favoriteAsunc = ref.watch(favoritePhotoViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Photo')),
      body: photoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Không thể tải ảnh: $error')),
        data: (photos) {
         return favoriteAsunc.when(
           loading: () => const Center(
             child: CircularProgressIndicator(),
           ),
           error: (error, stackTrace) => Center(child: Text('Lỗi WishList: $error'),),
           data: (favorites) {
             if(photos.isEmpty){
               return const Center(child: Text('chưa có ảnh'),);
             }
             final favoriteIds = favorites
                 .map((photo) => photo.photoId)
                 .toSet();
             return ListView.builder(
               itemCount: photos.length,
               itemBuilder: (context, index){
                 final photo = photos[index];

                 final isFavorite = favoriteIds.contains(photo.photoId);

                 return PhotoCard(
                   key: ValueKey(photo.photoId),
                   photo: photo,
                   isFavorite: isFavorite,
                   onFavoritePress: (){
                     final viewModel = ref.read(favoritePhotoViewModelProvider.notifier);
                     if(isFavorite){
                       viewModel.deleteFavoritePhoto(photo.photoId);
                     }else{
                       viewModel.addFavoritePhoto(photo);
                     }
                   },
                 );
               },
             );
           },

         );
        },
      ),
    );
  }
}
