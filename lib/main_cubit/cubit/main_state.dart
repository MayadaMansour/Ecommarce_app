part of 'main_cubit.dart';

abstract class MainState {}

class MainInitial extends MainState {}

class ChangeBottomNavBar extends MainState {}

//Home_Data
class LoadingHomeData extends MainState {}
class SuccessHomeData extends MainState {}
class ErrorHomeData extends MainState {}

//Category_Data
class SuccessCategoresData extends MainState {}
class ErrorCategoreseData extends MainState {}
class LoadingCategoreseData extends MainState {}

//Post_Favorite_Data
class SuccessFavoritesData extends MainState {
 final ChangeFavoritesModel model;
  SuccessFavoritesData(this.model);
}
class ErrorFavoritesData extends MainState {}
class LoadingFavoritesData extends MainState {}
//Post_Favorite
class SuccessFavorites extends MainState {}

//Get_Favorite_Data
class SuccessGetFavoritesData extends MainState {}
class ErrorGetFavoriteseData extends MainState {}
class LoadingGetFavoritesData extends MainState {}

//User_Data
class SuccessGetUserData extends MainState {
 final ShopLoginModel loginModel;
  SuccessGetUserData(this.loginModel);
}
class ErrorGetUserData extends MainState {}
class LoadingGetUserData extends MainState {}