import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/favourite/data/models/favourite_carditem.dart';
import 'package:ecommerce/features/favourite/data/repo/favouriterepo.dart';
import 'package:meta/meta.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRepository repository;

  FavouriteCubit(this.repository) : super(FavouriteInitial()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      final favourites = await repository.getFavorites();
      print('Loaded favorites: $favourites'); // For debugging purposes
      emit(FavouriteLoaded(_sortNotes(favourites)));
    } catch (e) {
      emit(FavouriteFailure(e.toString()));
    }
  }

  Future<void> addFavorite(CardItemModel item) async {
    try {
      await repository.addFavorite(item);
      loadFavorites();
    } catch (e) {
      emit(FavouriteFailure(e.toString()));
    }
  }

  Future<void> removeFavorite(CardItemModel item) async {
    try {
      await repository.removeFavorite(item);
      loadFavorites();
    } catch (e) {
      emit(FavouriteFailure(e.toString()));
    }
  }

  bool isFavorite(CardItemModel item) {
    if (state is FavouriteLoaded) {
      return (state as FavouriteLoaded)
          .favouritelist
          .any((favourite) => favourite == item);
    }
    return false;
  }

  List<CardItemModel> _sortNotes(List<CardItemModel> product) {
    product.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return product;
  }
}
