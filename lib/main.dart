import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

void main() {
  // ProviderScope giữ trạng thái Riverpod dùng chung cho toàn bộ ứng dụng.
  runApp(const ProviderScope(child: MyApp()));
}
