
class Product{
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String? description;
  final String? image;
  final int discountPercent; // 0–100
  double get salePrice => price * (1 - discountPercent / 100);
  final double rating;   // Điểm trung bình, ví dụ 4.8 trên 5
  final int reviewCount; // Số lượt đánh giá, ví dụ 120

  Product({
    required this.id,
    required this.name,
    this.quantity=0,
    this.price = 100.00,
    this.description = "",
    this.image = "",
    this.discountPercent = 0,
    this.rating = 0,
    this.reviewCount = 0,
  });

  //CopyWith = get của Java
  Product copyTo({
    String? id,
    String? name,
    int? quantity,
    double? price,
    String? description,
    String? image
  }){
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      discountPercent: discountPercent ?? this.discountPercent,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount
    );
  }

  //fromJson (Thường dùng để parse dữ liệu từ API về )
  factory Product.fromJson(Map<String,dynamic> json){
    return Product(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'None Name',
      quantity: json['quantity'] as int? ?? 0,
      price: json['price'] as double? ?? 100.00,
      description: json['description'] as String? ?? '',
      image: json['image'] as String? ?? 'No Image',
      discountPercent: json['discountPercent'] as int? ?? 0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      rating: json['rating'] as double? ?? 0.00
    );
  }

  //toJson (dùng để gửi dữ liệu đi)
  Map<String, dynamic>toJson(){
    return{
      'id' : id,
      'name': name,
      'quantity' : quantity,
      'description' : description,
      'image' : image,
      'discountPercent':discountPercent,
      'reviewCount':reviewCount,
      'rating':rating
  };
}

  //toString
  @override
  String toString(){
    return
      '''
      Product(
      id: $id
      name: $name
      quantity: $quantity
      price: $price
      description: $description
      image: $image
      discountPercent:$discountPercent
      reviewCount:$reviewCount
      rating:$rating
      )
      ''';
  }
  //So sánh bằng giá trị

  @override
  bool operator == (Object other){
   if(identical(this, other)) return true;
   return other is Product &&
    other.id == id &&
    other.name == name &&
    other.price == price&&
    other.quantity == quantity&&
    other.discountPercent == discountPercent&&
    other.rating == rating&&
    other.reviewCount == reviewCount;
  }

  //Hash code
  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode ^ quantity.hashCode ^ discountPercent.hashCode ^ reviewCount.hashCode ^ rating.hashCode;
}