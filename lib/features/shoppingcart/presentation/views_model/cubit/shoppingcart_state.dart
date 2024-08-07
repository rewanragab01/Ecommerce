part of 'shoppingcart_cubit.dart';

@immutable
abstract class ShoppingcartState {}

class ShoppingcartInitial extends ShoppingcartState {}

class CartItemsLoading extends ShoppingcartState {}

class CartItemsLoaded extends ShoppingcartState {
  final List<CardItemModel> cartitemlist;

  CartItemsLoaded(this.cartitemlist);
}

class CartItemsFailure extends ShoppingcartState {
  final String errormessage;

  CartItemsFailure(this.errormessage);
}
