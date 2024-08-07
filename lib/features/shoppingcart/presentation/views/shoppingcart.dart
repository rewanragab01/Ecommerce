import 'package:ecommerce/core/widgets/favcart_carditem.dart';
import 'package:ecommerce/features/shoppingcart/presentation/views_model/cubit/shoppingcart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Color(0xffFD6E87),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          BlocBuilder<ShoppingcartCubit, ShoppingcartState>(
            builder: (context, state) {
              if (state is CartItemsLoaded) {
                final cartitemlist = state.cartitemlist;
                if (cartitemlist.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            //   height: 70,
                            //   width: 70,
                            //   decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //           image: AssetImage(
                            //               'assets/images/emptycart.png'))),
                            // ),
                            ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(
                      bottom:
                          80), // Add bottom padding to avoid overlap with the button
                  itemCount: cartitemlist.length,
                  itemBuilder: (context, index) {
                    final cartitem = cartitemlist[index];
                    return FavCart_CardItem(
                      item: cartitem,
                      cart: true,
                      onremoveitem: () =>
                          BlocProvider.of<ShoppingcartCubit>(context)
                              .removeitem(cartitem),
                      onDecreaseQuantity: () =>
                          BlocProvider.of<ShoppingcartCubit>(context)
                              .decreaseQuantity(cartitem.name),
                      onIncreaseQuantity: () =>
                          BlocProvider.of<ShoppingcartCubit>(context)
                              .increaseQuantity(cartitem.name),
                    );
                  },
                );
              } else if (state is CartItemsFailure) {
                return Center(
                  child: Text(state.errormessage),
                );
              } else if (state is CartItemsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container();
              }
            },
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: 30,
          //   child: AppTextButton(
          //     icon: Icons.shopping_cart_checkout_outlined,
          //     iconColor: Colors.white,
          //     buttonText: '  Checkout',
          //     borderColor: Colors.white,
          //     textStyle: TextStyle(
          //         color: Colors.white,
          //         fontSize: 20,
          //         fontWeight: FontWeight.w600),
          //     onPressed: () {},
          //     backgroundColor: Colors.red[300],
          //   ),
          // ),
        ],
      ),
    );
  }
}
