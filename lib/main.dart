import 'package:ecommerce/features/auth/presentation/views/authscreen.dart';
import 'package:ecommerce/features/auth/presentation/views/widgets/forgetpasswordscreen.dart';
import 'package:ecommerce/features/favourite/data/models/favourite_carditem.dart';
import 'package:ecommerce/features/favourite/data/repo/favouriterepo.dart';
import 'package:ecommerce/features/favourite/presentation/views_model/cubit/favourite_cubit.dart';
import 'package:ecommerce/features/getstart/presentation/views/getstartscreen.dart';
import 'package:ecommerce/features/home/presentation/views/homebody.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/Categoriesscreen.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/changepassword.dart';

import 'package:ecommerce/features/onboardings/presentation/views/onboardingscreens.dart';
import 'package:ecommerce/features/shoppingcart/data/repo/shoppingcart_repo.dart';
import 'package:ecommerce/features/shoppingcart/presentation/views_model/cubit/shoppingcart_cubit.dart';
import 'package:ecommerce/features/splash/presentation/views/splashscreen.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(CardItemModelAdapter());
  await Hive.openBox<CardItemModel>('favoritesBox');
  await Hive.openBox<CardItemModel>('shoppingBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final favouriteRepository = FavouriteRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavouriteCubit(favouriteRepository)),
        BlocProvider(
          create: (context) => ShoppingcartCubit(ShoppingRepository()),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          routes: {
            '/onboardingscreen': (context) => const OnboardingScreens(),
            '/login': (context) => const AuthScreen(
                  authstate: 'login',
                ),
            '/signup': (context) => const AuthScreen(
                  authstate: 'signup',
                ),
            '/forgetpasswordscreen': (context) => const ForgetPasswordPage(),
            '/getstarted': (context) => const GetStartedScreen(),
            '/home': (context) => HomeBody(),
            '/categories': (context) => CategoriesScreen(),
            '/changepassword': (context) => ChangePassword(),
          }),
    );
  }
}
