import 'package:hoc_tren_truong/data/services/shop_data_service.dart';

class FakeShopDataService implements ShopDataService {
  FakeShopDataService({this.collections = const {}});
  final Map<String, List<Map<String, dynamic>>> collections;
  Object? failure;
  int calls = 0;
  @override
  Future<List<Map<String, dynamic>>> readCollection(String name) async {
    calls++;
    if (failure case final error?) throw error;
    return collections[name] ?? [];
  }
}
