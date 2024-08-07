// class ProductModel {
//   final int id;
//   final int price;
//   final int oldPrice;
//   final int discount;
//   final String image;
//   final String name;
//   final String description;
//   final List<String> images;
//   final bool inFavorites;
//   final bool inCart;

//   ProductModel({
//     required this.id,
//     required this.price,
//     required this.oldPrice,
//     required this.discount,
//     required this.image,
//     required this.name,
//     required this.description,
//     required this.images,
//     required this.inFavorites,
//     required this.inCart,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'],
//       price: json['price'],
//       oldPrice: json['old_price'],
//       discount: json['discount'],
//       image: json['image'] ?? '',
//       name: json['name'] ?? '',
//       description: json['description'],
//       images: List<String>.from(json['images']),
//       inFavorites: json['in_favorites'],
//       inCart: json['in_cart'],
//     );
//   }
//   @override
//   String toString() {
//     return 'ProductModel(name: $name, image: $image)';
//   }
// }

// class ProductModel {
//   final String name;
//   final String image;
//   final int id;
//   final double price;
//   final double oldPrice;
//   final String description;
//   final List<String> images;
//   ProductModel({
//     required this.name,
//     required this.image,
//     required this.id,
//     required this.price,
//     required this.oldPrice,
//     required this.description,
//     required this.images,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: (json['id'] as num).toInt(),
//       name: json['name'],
//       image: json['image'],
//       price: (json['price'] as num).toDouble(),
//       oldPrice: (json['old_price'] as num).toDouble(),
//       description: json['description'],
//       images: List<String>.from(json['images']),
//     );
//   }
// }
class ProductModel {
  final String name;
  final String image;
  final int id;
  final double price;
  final double oldPrice;
  final String description;
  final List<String> images;

  ProductModel({
    required this.name,
    required this.image,
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.description,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      oldPrice: (json['old_price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }
}
