import 'package:ecommerce/core/widgets/app_text_button.dart';
import 'package:ecommerce/features/favourite/data/models/favourite_carditem.dart';
import 'package:ecommerce/features/home/data/model/productmodel.dart';
import 'package:ecommerce/features/shoppingcart/presentation/views_model/cubit/shoppingcart_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    final double screenHeight = MediaQuery.of(context).size.height;
    final cardItemModel = CardItemModel(
        imageUrl: product.image,
        name: product.name,
        price: product.price,
        oldPrice: product.oldPrice,
        timestamp: DateTime.now());
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xffFD6E87),
        title: Text(
          'Product Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Swiper for images
          SizedBox(
            height: screenHeight *
                0.55, // Set the height to 55% of the screen height
            child: Swiper(
              itemCount: product.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(product.images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              autoplay: true,
              pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  color: Colors.grey.withOpacity(0.5),
                  activeColor: Colors.black,
                  size: 8.0,
                  activeSize: 12.0,
                ),
              ),
              control: SwiperControl(
                color: Colors.black,
                size: 24.0,
              ),
            ),
          ),
          // Container for the remaining space
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 10),
                  ),
                ],
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 2.0, // Border width
                ),
              ),
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Price: ${product.price.toString()}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<ShoppingcartCubit, ShoppingcartState>(
                      builder: (context, state) {
                        final isInCart = context
                            .read<ShoppingcartCubit>()
                            .isItemInCart(cardItemModel);

                        if (state is CartItemsFailure) {
                          return Center(
                            child: Text(state.errormessage),
                          );
                        } else if (isInCart) {
                          return AppTextButton(
                              iconColor: Colors.white,
                              buttonText: 'Added',
                              backgroundColor: Color(0xffFD6E87),
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 18),
                              onPressed: () {});
                        } else {
                          return AppTextButton(
                              icon: Icons.add_shopping_cart,
                              iconColor: Colors.white,
                              buttonText: '  Add to Cart',
                              backgroundColor: Color(0xffFD6E87),
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 18),
                              onPressed: () {
                                BlocProvider.of<ShoppingcartCubit>(context)
                                    .additem(cardItemModel);
                              });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
