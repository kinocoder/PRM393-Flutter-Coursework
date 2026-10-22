import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/data/model/photo_api_model.dart';

class PhotoCard extends StatelessWidget {
  final PhotoApiModel photo;

  const PhotoCard({
    super.key,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: ListTile(
        leading: Image.network(
          photo.thumbnailUrl,
          width: 64,
          height: 64,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image);
          },
        ),
        title: Text(photo.title),
        subtitle: Text('Photo ID: ${photo.photoId}'),
      ),
    );
  }
}