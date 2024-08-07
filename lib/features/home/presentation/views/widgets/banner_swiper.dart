import 'package:ecommerce/features/home/data/model/bannermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class Banner_Swiper extends StatelessWidget {
  const Banner_Swiper({super.key, required this.banners});
  final List<BannerModel> banners;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Swiper(
        itemCount: banners.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(banners[index].image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        autoplay: true,
        pagination: null,
        control: null,
      ),
    );
  }
}
