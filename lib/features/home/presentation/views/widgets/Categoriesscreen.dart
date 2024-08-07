import 'package:ecommerce/features/home/data/repos/categoriesrepo.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/categoryproductscreen.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/customcategory.dart';
import 'package:ecommerce/features/home/presentation/views_model/cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoriesCubit(CategoriesRepository())..fetchCategories(),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            'Categories',
            style: TextStyle(color: Colors.white),
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
            } else if (state is Categoriessuccess) {
              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = state.categories[index];
                  return Column(
                    children: [
                      CustomCategory(
                        categoryname: category.name,
                        imageurl: category.image,
                        onpress: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CategoryProductsScreen(
                                  categoryId: category.id,
                                  categoryName: category.name);
                            },
                          ));
                        },
                      ),
                      index == state.categories.length - 1
                          ? SizedBox()
                          : Divider(
                              indent: 10,
                              endIndent: 10,
                              height: 20,
                              color: Colors.grey,
                              thickness: 1,
                            ),
                    ],
                  );
                },
              );
            } else if (state is Categoriesfailure) {
              return Center(
                  child: Text('there is an error :${state.errormessage}'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
