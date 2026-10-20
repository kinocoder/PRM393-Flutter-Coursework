import 'dart:convert';

class PhotoApiModel {
  final String photoId;
  final String title;
  final String url;
  final String thumnailUrl;

  PhotoApiModel({
    required this.photoId,
    required this.title,
    required this.url,
    required this.thumnailUrl,
  });

  factory PhotoApiModel.fromJson(Map<String, dynamic> json) {
    return PhotoApiModel(
      photoId: json['id'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      thumnailUrl: json['thumbnailUrl'] as String,
    );
  }

}
