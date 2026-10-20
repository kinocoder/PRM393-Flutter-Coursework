import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/post.dart';

part 'post_repository.g.dart';

@riverpod
http.Client postHttpClient(Ref ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
}

@riverpod
PostRepository postRepository(Ref ref) {
  return PostRepository(ref.watch(postHttpClientProvider));
}

class PostRepository {
  PostRepository(this._client);

  static final Uri _postsUri = Uri.https(
    'jsonplaceholder.typicode.com',
    '/posts',
  );

  final http.Client _client;

  Future<List<Post>> getPosts() async {
    final response = await _client.get(_postsUri);
    _throwIfRequestFailed(response);

    final jsonList = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    return jsonList
        .map((json) => Post.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList(growable: false);
  }

  Future<Post> getPostById(int id) async {
    if (id < 1) {
      throw ArgumentError.value(id, 'id', 'ID phải lớn hơn hoặc bằng 1');
    }

    final postUri = _postsUri.replace(
      pathSegments: [..._postsUri.pathSegments, '$id'],
    );
    final response = await _client.get(postUri);
    _throwIfRequestFailed(response);

    final json = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as Map<String, dynamic>;
    return Post.fromJson(json);
  }

  void _throwIfRequestFailed(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Không thể tải bài viết (HTTP ${response.statusCode}).',
      );
    }
  }
}
