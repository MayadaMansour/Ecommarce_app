import 'package:bloc/bloc.dart';
import 'package:ecommarce_app/data/remote/dio_helper.dart';
import 'package:ecommarce_app/models/login_model.dart';
import 'package:ecommarce_app/view/modules/login/cubit/states.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool showPassword = true;
  IconData icona = Icons.visibility_outlined;
  late ShopLoginModel loginModel;

  void changeIcona() {
    showPassword = !showPassword;
    showPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(ShopChangePasswordVisibilityState());
  }

  void usersLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: "login",
        data: {"email": email, "password": password}).then((value) {
            loginModel = ShopLoginModel.fromjson(value?.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}