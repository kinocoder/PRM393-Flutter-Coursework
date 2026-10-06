import '../../domain/models/product.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ProductRepository.g.dart';

@riverpod
Productrepository productrepository(Ref ref) {
  return Productrepository();
}

class Productrepository {
  final List<Product> products = [
    Product(
      id: 'p001',
      name: 'iPhone 15',
      quantity: 20,
      price: 18000000.0,
      description:
          'Điện thoại màn hình 6.1 inch, bộ nhớ 128GB, '
          'phù hợp chụp ảnh và sử dụng hằng ngày.',
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQe9u7lROaPnBP_Ktr0jzE25o90MdtiXp_XAdvYFIfVhw&s=10',
      discountPercent: 10,
      rating: 4.8,
      reviewCount: 120,
      categoryId: 'phone',
    ),
    Product(
      id: 'p002',
      name: 'Samsung Galaxy S24',
      quantity: 15,
      price: 20000000.0,
      description:
          'Điện thoại Android với màn hình sắc nét, '
          'camera đa dụng và thiết kế nhỏ gọn.',
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyIh667fQ8iYrmTT0N3ihzNpzTeEICzLK42ZsYGgqBcCLO7GQdzZuGISn1&s=10',
      discountPercent: 15,
      rating: 4.7,
      reviewCount: 95,
      categoryId: 'phone',
    ),
    Product(
      id: 'p003',
      name: 'Dell Inspiron 15',
      quantity: 8,
      price: 15000000.0,
      description:
          'Laptop màn hình 15.6 inch, RAM 16GB, SSD 512GB, '
          'phù hợp học tập và làm việc văn phòng.',
      image:
          'https://m.media-amazon.com/images/I/71%2BWacn3fzL._AC_SL1500_.jpg',
      discountPercent: 5,
      rating: 4.5,
      reviewCount: 64,
      categoryId: 'laptop',
    ),
    Product(
      id: 'p004',
      name: 'Logitech M331',
      quantity: 50,
      price: 350000.0,
      description:
          'Chuột không dây với nút bấm êm, '
          'phù hợp học tập và sử dụng văn phòng.',
      image: 'https://resource.logitech.com/w_544%2Ch_466%2Car_7%3A6%2Cc_pad%2Cq_auto%2Cf_auto%2Cdpr_1.0/d_transparent.gif/content/dam/logitech/en/products/mice/m330-wireless-silent-mouse/2024-update/gallery/m330-wireless-mouse-top-view-black-gallery-01.png',
      discountPercent: 0,
      rating: 4.6,
      reviewCount: 210,
      categoryId: 'accessory',
    ),
    Product(
      id: 'p005',
      name: 'Sony WH-CH520',
      quantity: 12,
      price: 1200000.0,
      description:
          'Tai nghe Bluetooth chụp tai, '
          'phù hợp nghe nhạc và học trực tuyến.',
      image: 'https://sony.scene7.com/is/image/sonyglobalsolutions/00-7?%24large360ViewerImage%24=',
      discountPercent: 20,
      rating: 4.4,
      reviewCount: 78,
      categoryId: 'audio',
    ),
  ];

  //Lấy  tất cả sản phẩm
  Future<List<Product>> getProducts() async {
    return List<Product>.unmodifiable(products);
  }

  //Lấy sản phẩm theo ID
  Future<Product?> getProductByID(String id) async {
    for (final product in products) {
      if (product.id == id) {
        return product;
      }
    }
    return null;
  }

  //lấy sản phẩm theo tên
  Future<List<Product>> getProductByName(String name) async {
    final keyword = name.trim().toLowerCase();
    final results = products.where((product) {
      return product.name.toLowerCase().contains(keyword);
    }).toList();
    return results;
  }
}
