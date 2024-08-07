import 'package:hive_flutter/hive_flutter.dart';

part 'favourite_carditem.g.dart';

@HiveType(typeId: 0)
class CardItemModel extends HiveObject {
  @HiveField(0)
  final String imageUrl;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final double oldPrice;
  @HiveField(4)
  final DateTime timestamp;
  @HiveField(5)
  int quantity;
  CardItemModel({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.timestamp,
    this.quantity = 1,
  });
  @override
  String toString() {
    return 'CardItemModel(imageUrl: $imageUrl, name: $name, price: $price, oldPrice: $oldPrice,timestamp: $timestamp,quantity:$quantity)';
  }
}
