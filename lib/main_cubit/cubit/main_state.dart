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

//Post_Favorite
class SuccessFavoritesData extends MainState {
 final ChangeFavoritesModel model;
  SuccessFavoritesData(this.model);
}
class SuccessFavorites extends MainState {}
class ErrorFavoritesData extends MainState {}

//Get_Favorite
class SuccessGetFavoritesData extends MainState {}
class ErrorGetFavoriteseData extends MainState {}
class LoadingGetFavoritesData extends MainState {}

//User_Data
class SuccessGetUserData extends MainState {}
class ErrorGetUserData extends MainState {}