import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/favourite/data/models/favourite_carditem.dart';
import 'package:ecommerce/features/shoppingcart/data/repo/shoppingcart_repo.dart';
import 'package:flutter/material.dart';

part 'shoppingcart_state.dart';

class ShoppingcartCubit extends Cubit<ShoppingcartState> {
  final ShoppingRepository repository;
  ShoppingcartCubit(this.repository) : super(ShoppingcartInitial()) {
    loadcartitems();
  }
  Future<void> loadcartitems() async {
    try {
      emit(CartItemsLoading());
      final cartitems = await repository.getitems();
      print('Loaded cartitems: $cartitems'); // For debugging purposes
      emit(CartItemsLoaded(_sortNotes(cartitems)));
    } catch (e) {
      emit(CartItemsFailure(e.toString()));
    }
  }

  Future<void> additem(CardItemModel item) async {
    try {
      await repository.additemtocart(item);
      loadcartitems();
    } catch (e) {
      emit(CartItemsFailure(e.toString()));
    }
  }

  Future<void> removeitem(CardItemModel item) async {
    try {
      await repository.removeitemfromcart(item);
      loadcartitems();
    } catch (e) {
      emit(CartItemsFailure(e.toString()));
    }
  }

  bool isItemInCart(CardItemModel item) {
    if (state is CartItemsLoaded) {
      return (state as CartItemsLoaded)
          .cartitemlist
          .any((cartItem) => cartItem.name == item.name);
    }
    return false;
  }

  List<CardItemModel> _sortNotes(List<CardItemModel> product) {
    product.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return product;
  }

  Future<void> increaseQuantity(String name) async {
    await repository.increaseQuantity(name);
    loadcartitems();
  }

  Future<void> decreaseQuantity(String name) async {
    await repository.decreaseQuantity(name);
    loadcartitems();
  }
}
