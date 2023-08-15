import 'package:ecommarce_app/constans.dart';
import 'package:ecommarce_app/data/remote/dio_helper.dart';
import 'package:ecommarce_app/data/remote/end_point.dart';
import 'package:ecommarce_app/models/add_favorite_model.dart';
import 'package:ecommarce_app/models/categories_model.dart';
import 'package:ecommarce_app/models/get_favorite_model.dart';
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
  CategoriesModel? categorisModel;
  Map<int, bool> favorites = {};
  int index = 0;
  late ChangeFavoritesModel changeFavoritesModel;
  GetFavorite? getFavorites;
   late ShopLoginModel userdata;
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
       for (var e in homeModel!.data!.products) {
        favorites.addAll({e.id!: e.inFavorites!});
      }
      emit(SuccessHomeData());
    }).catchError((error) {
      emit(ErrorHomeData());
    });
  }

  void getCategorisData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categorisModel = CategoriesModel.fromjson(value.data);
      emit(SuccessCategoresData());
    }).catchError((error) {
      emit(ErrorCategoreseData());
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(SuccessFavorites());
    DioHelper.postData(
            url: FAVORITES,
        data: {"product_id": productId},
        token: token)
        .then((value) {
       changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data);
        if (changeFavoritesModel.status == false) {
        favorites[productId] = !favorites[productId]!;
      }  else {
        getFavoritesData();
      }
      emit(SuccessFavoritesData(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ErrorFavoritesData());
    });
  }

  void getFavoritesData() {
    emit(LoadingGetFavoritesData());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      getFavorites = GetFavorite.fromjson(value.data);
      emit(SuccessGetFavoritesData());
    }).catchError((error) {
      emit(ErrorGetFavoriteseData());
    });
  }



  void getUserdata() {
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userdata = ShopLoginModel.fromjson(value.data);
      emit(SuccessGetUserData(userdata));
    }).catchError((error) {
      emit(ErrorGetUserData());
    });
  }
}
