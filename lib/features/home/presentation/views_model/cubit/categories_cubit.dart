import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/home/data/model/categoriesmodel.dart';
import 'package:ecommerce/features/home/data/model/productmodel.dart';
import 'package:ecommerce/features/home/data/repos/categoriesrepo.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepository _categoriesRepository;

  CategoriesCubit(this._categoriesRepository) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(Categoriesload());
    try {
      final categories = await _categoriesRepository.fetchCategories();
      emit(Categoriessuccess(categories));
    } catch (e) {
      emit(Categoriesfailure('An error occurred: ${e.toString()}'));
    }
  }

  Future<void> fetchCategoriesproduct(int id) async {
    emit(Categoriesload());
    try {
      final categoriesproduct =
          await _categoriesRepository.fetchCategoriesProduct(id);
      emit(Categoriesproductsuccess(categoriesproduct));
    } catch (e) {
      emit(Categoriesfailure('An error occurred: ${e.toString()}'));
    }
  }
}
