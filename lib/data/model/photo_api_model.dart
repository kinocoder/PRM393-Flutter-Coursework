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

  Map<String, Object> toMap(){
    return {
      'photoId' : photoId,
      'title' : title,
      'url' : url,
      'thumbnailUrl' : thumbnailUrl
    };
  }


}
