part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class Categoriesload extends CategoriesState {}

final class Categoriessuccess extends CategoriesState {
  final List<Category> categories;
  Categoriessuccess(this.categories);
}

final class Categoriesproductsuccess extends CategoriesState {
  final List<ProductModel> categoriesproduct;
  Categoriesproductsuccess(this.categoriesproduct);
}

final class Categoriesfailure extends CategoriesState {
  final String errormessage;
  Categoriesfailure(this.errormessage);
}
