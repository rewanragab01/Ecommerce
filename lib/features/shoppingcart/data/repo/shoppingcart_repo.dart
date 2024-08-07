import 'package:ecommerce/features/favourite/data/models/favourite_carditem.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShoppingRepository {
  final String _boxName = 'shoppingBox';
  late Box<CardItemModel> box;

  ShoppingRepository() {
    _initBox();
  }

  Future<void> _initBox() async {
    box = await Hive.openBox<CardItemModel>(_boxName);
  }

  Future<void> additemtocart(CardItemModel item) async {
    var box = await Hive.openBox<CardItemModel>(_boxName);
    await box.put(item.name, item);
  }

  Future<void> removeitemfromcart(CardItemModel item) async {
    var box = await Hive.openBox<CardItemModel>(_boxName);
    await box.delete(item.name);
  }

  Future<List<CardItemModel>> getitems() async {
    final box = await Hive.openBox<CardItemModel>(_boxName);
    final favorites = box.values.toList();
    print("Loaded cartitems: $favorites"); // Debug print
    return favorites;
  }

  Future<void> increaseQuantity(String name) async {
    var box = await Hive.openBox<CardItemModel>(_boxName);
    final item = box.get(name);
    if (item != null) {
      item.quantity++;
      await box.put(item.name, item);
    }
  }

  Future<void> decreaseQuantity(String name) async {
    var box = await Hive.openBox<CardItemModel>(_boxName);
    final item = box.get(name);
    if (item != null && item.quantity > 1) {
      item.quantity--;
      await box.put(item.name, item);
    }
  }
}
