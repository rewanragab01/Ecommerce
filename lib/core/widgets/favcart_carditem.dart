import 'package:ecommerce/features/favourite/data/models/favourite_carditem.dart';
import 'package:ecommerce/features/favourite/presentation/views_model/cubit/favourite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavCart_CardItem extends StatelessWidget {
  const FavCart_CardItem(
      {super.key,
      required this.item,
      this.cart = false,
      this.onremoveitem,
      this.onDecreaseQuantity,
      this.onIncreaseQuantity});

  final CardItemModel item;
  final bool cart;
  final void Function()? onremoveitem;
  final void Function()? onIncreaseQuantity;
  final void Function()? onDecreaseQuantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  item.imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.contain, // Adjust image scaling
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 4),
                    cart
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: onIncreaseQuantity,
                              ),
                              Text(
                                item.quantity.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: onDecreaseQuantity,
                              ),
                            ],
                          )
                        : Text(
                            '\$${item.oldPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.25),
                              decoration: item.oldPrice == item.price
                                  ? TextDecoration.none
                                  : TextDecoration.lineThrough,
                            ),
                          )
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: cart
                    ? onremoveitem
                    : () => context.read<FavouriteCubit>().removeFavorite(item),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
