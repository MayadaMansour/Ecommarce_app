
import 'package:ecommarce_app/data/local/cache_helper.dart';
import 'package:ecommarce_app/main_cubit/cubit/main_cubit.dart';
import 'package:ecommarce_app/view/modules/home/home_screen.dart';
import 'package:ecommarce_app/view/modules/login/ui/login_screen.dart';
import 'package:ecommarce_app/view/modules/onboard/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constans.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  Widget widget;
  dynamic onBoarding = CachHelper.getData(key: "onBoarding");
  token = CachHelper.getData(key: "saveToken");


  if (onBoarding != null) {
    if (token != null) {
      widget =  HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBordingScreen();
  }
  runApp(ShopApp(startWidget: widget));
}


class ShopApp extends StatelessWidget {
  ShopApp({super.key, this.startWidget});
  Widget? startWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..getHomeData()
        ..getCategorisData()
        ..getFavoritesData()
        ..getUserdata(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}