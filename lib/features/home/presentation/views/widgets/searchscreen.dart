import 'package:ecommerce/features/home/data/repos/homerepo.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/productdetails.dart';
import 'package:ecommerce/features/home/presentation/views_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/core/widgets/app_text_form_field.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return BlocProvider(
      create: (context) => HomeCubit(HomeRepository()),
      child: Search_Body(controller: controller),
    );
  }
}

class Search_Body extends StatefulWidget {
  const Search_Body({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<Search_Body> createState() => _Search_BodyState();
}

class _Search_BodyState extends State<Search_Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(children: [
          AppTextFormField(
              hintText: 'Search any Product...',
              controller: widget.controller,
              backgroundColor: Colors.white,
              suffixIcon: Icon(
                Icons.search,
                color: Color(0xffBBBBBB),
                size: 24,
              ),
              color: Color(0xffBBBBBB),
              borderRadius: BorderRadius.circular(8),
              onChanged: (query) {
                context.read<HomeCubit>().searchProducts(query);
              }),
          SizedBox(height: 16),
          Expanded(child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProductsSearch) {
                return ListView.builder(
                  itemCount: state.filteredproducts.length,
                  itemBuilder: (context, index) {
                    final products = state.filteredproducts[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetails(product: products),
                          )),
                      child: ListTile(
                        title: Text(products.name),
                        subtitle: Text(products.price.toString()),
                        leading: Image.network(products.image),
                      ),
                    );
                  },
                );
              } else if (state is EmptyProductsSearch) {
                return Center(
                    child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/noresult.png'))),
                ));
              } else {
                return Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/search.png'),
                      )),
                    ),
                    Text(
                      'Search Now !',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ));
              }
            },
          )),
        ]));
  }
}
