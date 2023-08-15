import 'package:ecommarce_app/data/local/cache_helper.dart';
import 'package:ecommarce_app/view/modules/login/ui/login_screen.dart';
import 'package:flutter/material.dart';

dynamic token = "";
void SignOut(context){
  CachHelper.deleteItem(key: "token").then((value) => {
    if(value){
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ))
    }
  });

}