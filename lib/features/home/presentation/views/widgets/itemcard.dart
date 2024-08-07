import 'package:ecommerce/features/favourite/presentation/views_model/cubit/favourite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/favourite/data/models/favourite_carditem.dart';

class CardItem extends StatelessWidget {
  CardItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.oldprice,
  });

  final String imageUrl;
  final String name;
  final double price;
  final double oldprice;

  @override
  Widget build(BuildContext context) {
    final favouriteCubit = context.read<FavouriteCubit>();
    final cardItemModel = CardItemModel(
        imageUrl: imageUrl,
        name: name,
        price: price,
        oldPrice: oldprice,
        timestamp: DateTime.now());

    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        bool isFavourite = favouriteCubit.isFavorite(cardItemModel);

        return Card(
          color: Colors.white,
          elevation: 0.55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.25,
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.broken_image,
                    size: 100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$${oldprice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.25),
                              decoration: oldprice == price
                                  ? TextDecoration.none
                                  : TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: isFavourite ? Colors.red : null,
                      ),
                      onPressed: () {
                        if (isFavourite) {
                          favouriteCubit.removeFavorite(cardItemModel);
                        } else {
                          favouriteCubit.addFavorite(cardItemModel);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
