import 'package:ecommerce/features/home/data/repos/categoriesrepo.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/category_productcard.dart';
import 'package:ecommerce/features/home/presentation/views_model/cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen(
      {super.key, required this.categoryId, required this.categoryName});

  final int categoryId;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit(CategoriesRepository())
        ..fetchCategoriesproduct(categoryId),
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            foregroundColor: Colors.white,
            title: Text(
              categoryName,
            ),
            centerTitle: true,
            backgroundColor: Color(0xffFD6E87),
          ),
          body: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is Categoriesload) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is Categoriesproductsuccess) {
                return ListView.builder(
                  itemCount: state.categoriesproduct.length,
                  itemBuilder: (context, index) {
                    final product = state.categoriesproduct[index];
                    return product_CardItem(item: product);
                  },
                );
              } else if (state is Categoriesfailure) {
                return Center(
                  child: Text(state.errormessage),
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
