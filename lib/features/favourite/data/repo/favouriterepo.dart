import 'package:ecommerce/features/favourite/data/models/favourite_carditem.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavouriteRepository {
  final String _boxName = 'favoritesBox';
  late Box<CardItemModel> box;

  FavouriteRepository() {
    _initBox();
  }

  Future<void> _initBox() async {
    box = await Hive.openBox<CardItemModel>(_boxName);
  }

  Future<void> addFavorite(CardItemModel item) async {
    var box = await Hive.openBox<CardItemModel>(_boxName);
    await box.put(item.name, item);
  }

  Future<void> removeFavorite(CardItemModel item) async {
    var box = await Hive.openBox<CardItemModel>(_boxName);
    await box.delete(item.name);
  }

  Future<List<CardItemModel>> getFavorites() async {
    final box = await Hive.openBox<CardItemModel>(_boxName);
    final favorites = box.values.toList();
    print("Loaded favorites: $favorites"); // Debug print
    return favorites;
  }
}
