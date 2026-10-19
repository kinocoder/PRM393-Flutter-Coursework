import 'package:hoc_tren_truong/domain/models/cart_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'cartItem.dart';

class DataHelper {
  DataHelper._();

  static final DataHelper instance = DataHelper._();
  static const String cartTable = 'cart_items';

  Future<Database>? _database;

  Future<Database> get database => _database ??= _initData();

  Future<Database> _initData() async {
    final path = join(await getDatabasesPath(), 'ShoppingCart.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $cartTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            product TEXT NOT NULL,
            quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity > 0),
            is_selected INTEGER NOT NULL DEFAULT 0
              CHECK (is_selected IN (0, 1))
          )
        ''');
      },
    );
  }

  //1. lấy danh sách tát cả mặt hàng trong giở
  Future<List<CartItem1>> getCartItems() async{
    final db = await DataHelper.instance.database;
    List<Map<String, dynamic>> carts = await db.query('$cartTable');
    return carts.map((c) => CartItem1(
      product: c['product'] as String,
      quantity: c['quantity'] as int,
      isSelected: c['isSelected'] as bool
    )).toList();
  }
}
