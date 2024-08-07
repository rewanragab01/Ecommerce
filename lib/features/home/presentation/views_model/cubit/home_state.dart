part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeDataSuccess extends HomeState {
  final List<BannerModel> banners;
  final List<ProductModel> products;

  HomeDataSuccess(this.banners, this.products);
}

class HomeDataFailure extends HomeState {
  final String errorMessage;

  HomeDataFailure(this.errorMessage);
}

class ProductsSearch extends HomeState {
  final List<ProductModel> filteredproducts;
  ProductsSearch(this.filteredproducts);
}

class EmptyProductsSearch extends HomeState {
  EmptyProductsSearch();
}

class SearchLoading extends HomeState {}
