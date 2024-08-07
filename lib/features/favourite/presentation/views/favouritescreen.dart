import 'package:ecommerce/core/widgets/favcart_carditem.dart';
import 'package:ecommerce/features/favourite/presentation/views_model/cubit/favourite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourites',
          style: TextStyle(
            color: Color(0xffFD6E87),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavouriteLoaded) {
            final favourites = state.favouritelist;
            if (favourites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/nofavourites.png'))),
                    ),
                    Text(
                      'No favourite items yet',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final item = favourites[index];
                return FavCart_CardItem(item: item);
              },
            );
          } else if (state is FavouriteFailure) {
            return Center(
              child: Text('Failed to load favourites: ${state.errormessage}'),
            );
          } else {
            return Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}
