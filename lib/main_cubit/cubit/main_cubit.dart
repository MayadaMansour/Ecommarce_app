import 'package:ecommarce_app/constans.dart';
import 'package:ecommarce_app/data/remote/dio_helper.dart';
import 'package:ecommarce_app/data/remote/end_point.dart';
import 'package:ecommarce_app/models/home_model.dart';
import 'package:ecommarce_app/models/login_model.dart';
import 'package:ecommarce_app/view/modules/categories/categories_screen.dart';
import 'package:ecommarce_app/view/modules/favorite/favorite_screen.dart';
import 'package:ecommarce_app/view/modules/products/products_screen.dart';
import 'package:ecommarce_app/view/modules/seetings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
 // CategorisModel? categorisModel;
  Map<int, bool> favorites = {};
  int index = 0;

  /* late ChangeFavoritesModel changeFavoritesModel;
  GetFavorites? getFavorites; */
  
  List<Widget> screens = [
    ProductScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  void changeIcon(val) {
    index = val;
    emit(ChangeBottomNavBar());
  }

  void getHomeData() {
    emit(LoadingHomeData());
    DioHelper.getData(
      url:HOME,
      token: token,
    ).then((value) {
       homeModel = HomeModel.fromjson(value.data);
       print(homeModel!.data!.products[0].image);
       print(homeModel!.status);
      /* for (var e in homeModel!.data!.products) {
        favorites.addAll({e.id!: e.inFavorites!});
      } */
      // print(favorites.toString());
      emit(SuccessHomeData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeData());
    });
  }

  void getCategorisData() {
    DioHelper.getData(
      url: "categories",
      token: token,
    ).then((value) {
      //categorisModel = CategorisModel.fromjson(value.data);
      // print(categorisModel!.status);
      // print(categorisModel!.data!.dataModel[0].name);
      emit(SuccessCategoresData());
    }).catchError((error) {
      // print(error.toString());
      emit(ErrorCategoreseData());
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(SuccessFavorites());
    DioHelper.postData(
            url: "favorites", data: {"product_id": productId}, token: token)
        .then((value) {
      // changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data);
      // print(value.data);
      /*  if (changeFavoritesModel.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      } */
      //emit(SuccessFavoritesData(changeFavoritesModel));
    }).catchError((error) {
      emit(ErrorFavoritesData());
    });
  }

  void getFavoritesData() {
    emit(LoadingGetFavoritesData());
    DioHelper.getData(url: "favorites", token: token).then((value) {
      //getFavorites = GetFavorites.fromjson(value.data);
      // print(value.data.toString());
      emit(SuccessGetFavoritesData());
    }).catchError((error) {
      emit(ErrorGetFavoriteseData());
    });
  }

  ShopLoginModel? userdata;

  void getUserdata() {
    DioHelper.getData(url: "profile", token: token).then((value) {
      userdata = ShopLoginModel.fromjson(value.data);
      // print(value.data.toString());
      emit(SuccessGetUserData());
    }).catchError((error) {
      emit(ErrorGetUserData());
    });
  }
}
