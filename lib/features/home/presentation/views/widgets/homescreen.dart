import 'package:ecommerce/features/home/data/repos/categoriesrepo.dart';
import 'package:ecommerce/features/home/data/repos/homerepo.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/banner_swiper.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/categoryicon.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/itemcard.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/productdetails.dart';
import 'package:ecommerce/features/home/presentation/views_model/cubit/categories_cubit.dart';
import 'package:ecommerce/features/home/presentation/views_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/core/widgets/app_text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeRepository = HomeRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CategoriesCubit(CategoriesRepository())..fetchCategories(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(homeRepository)..fetchHomeData(),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, homeState) {
            return BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, categoriesState) {
                bool isLoading = homeState is HomeLoading ||
                    categoriesState is Categoriesload;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        if (isLoading)
                          const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xffFD6E87)),
                              strokeWidth: 4.0,
                            ),
                          )
                        else ...[
                          if (homeState is HomeDataSuccess)
                            Banner_Swiper(banners: homeState.banners),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Categories',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AppTextButton(
                                backgroundColor: Color(0xffFD6E87),
                                borderRadius: 5,
                                buttonHeight: 40,
                                buttonWidth: 75,
                                buttonText: 'View all',
                                textStyle: const TextStyle(color: Colors.white),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/categories');
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 125,
                            child:
                                BlocBuilder<CategoriesCubit, CategoriesState>(
                              builder: (context, state) {
                                if (state is Categoriessuccess) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.categories.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final category = state.categories[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: CategoryIcon(
                                          imageUrl: category.image,
                                          name: category.name,
                                        ),
                                      );
                                    },
                                  );
                                } else if (state is Categoriesfailure) {
                                  return Center(
                                      child:
                                          Text('Error: ${state.errormessage}'));
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'All Products',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (homeState is HomeDataSuccess)
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: homeState.products.length,
                              itemBuilder: (context, index) {
                                final product = homeState.products[index];

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetails(
                                          product: product,
                                        );
                                      },
                                    ));
                                  },
                                  child: CardItem(
                                    price: product.price,
                                    oldprice: product.oldPrice,
                                    imageUrl: product.image,
                                    name: product.name,
                                  ),
                                );
                              },
                            ),
                          if (homeState is HomeDataFailure)
                            Center(
                                child:
                                    Text('Error: ${homeState.errorMessage}')),
                        ]
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
