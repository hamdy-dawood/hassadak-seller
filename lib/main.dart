import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/cache_helper.dart';
import 'core/snack_and_navigate.dart';
import 'pages/bottom_nav_bar/view.dart';
import 'pages/delete_product/cubit.dart';
import 'pages/login/view.dart';
import 'pages/my_products/all_products/cubit.dart';
import 'pages/my_products/categories/cubit.dart';
import 'pages/on_boarding/view.dart';
import 'pages/profile/edit_data/cubit.dart';
import 'pages/profile/personal_data/cubit.dart';
import 'pages/upload_user_photo/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await CacheHelper.init();
  await Future.delayed(const Duration(seconds: 3), () {
    FlutterNativeSplash.remove();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFirstTime = CacheHelper.getIfFirstTime();
    String token = CacheHelper.getToken();
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AllCategoriesCubit()),
            BlocProvider(create: (context) => AllProductsCubit()),
            BlocProvider(create: (context) => PersonalDataCubit()),
            BlocProvider(create: (context) => EditDataCubit()),
            BlocProvider(create: (context) => DeleteProductCubit()),
            BlocProvider(create: (context) => UploadUserPhotoCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hassadak Seller',
            navigatorKey: navigatorKey,
            theme: ThemeData(
              platform: TargetPlatform.iOS,
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar', 'AE'),
            ],
            locale: const Locale('ar', 'AE'),
            home: child,
          ),
        );
      },
      child: isFirstTime
          ? const OnBoardingView()
          : token.isEmpty
              ? const LoginView()
              : const NavBarView(),
    );
  }
}
