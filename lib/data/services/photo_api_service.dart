import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hoc_tren_truong/data/model/photo_api_model.dart';

Future<List<PhotoApiModel>> fetchPhoto() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    headers: {'Accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    //Nếu đúng mã trả về thành công (200) thì sẽ chuyển dữ json về object
    final List<PhotoApiModel> jsonList = jsonDecode(response.body);
    return jsonList.map((item) {
      return PhotoApiModel.fromJson(item as Map<String, dynamic>);
    }).toList();
  } else {
    //sai ném ra lỗi cùng với mã lỗi
    throw Exception('Failed to load photo: HTTP ${response.statusCode}');
  }
}
