import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/home/data/model/bannermodel.dart';
import 'package:ecommerce/features/home/data/model/productmodel.dart';
import 'package:ecommerce/features/home/data/repos/homerepo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;
  HomeCubit(this.homeRepository) : super(HomeInitial());
  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final data = await homeRepository.fetchHomeData();
      final banners = data['banners'] as List<BannerModel>;
      final products = data['products'] as List<ProductModel>;
      emit(HomeDataSuccess(banners, products));
    } catch (e) {
      emit(HomeDataFailure('Error: ${e.toString()}'));
    }
  }

  void searchProducts(String query) async {
    final data = await homeRepository.fetchHomeData();
    final products = data['products'] as List<ProductModel>;
    if (query.isEmpty) {
      emit(HomeInitial());
    } else {
      emit(SearchLoading());
      final filteredProducts = products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      if (filteredProducts.isEmpty) {
        emit(EmptyProductsSearch());
      } else {
        emit(ProductsSearch(filteredProducts));
      }
    }
  }
}
