class PhotoApiModel {
  final int photoId;
  final String title;
  final String url;
  final String thumbnailUrl;

  PhotoApiModel({
    required this.photoId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoApiModel.fromJson(Map<String, dynamic> json) {
    return PhotoApiModel(
      photoId: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }

  factory PhotoApiModel.fromMap(Map<String, Object?> map){
    return PhotoApiModel(
      photoId: map['photo_id'] as int,
      title: map['title'] as String,
      url: map['url'] as String,
      thumbnailUrl: ['thumbnail_url'] as String
    );
  }

  Map<String, Object> toMap() {
    return {
      'photo_id': photoId,
      'title': title,
      'url': url,
      'thumbnail_url': thumbnailUrl,
    };
  }


}
