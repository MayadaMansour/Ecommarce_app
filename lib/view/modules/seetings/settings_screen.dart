import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommarce_app/constans.dart';
import 'package:ecommarce_app/main_cubit/cubit/main_cubit.dart';
import 'package:ecommarce_app/widgets/coustoms/coustom_bottom.dart';
import 'package:ecommarce_app/widgets/coustoms/coustom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MainCubit,MainState>(
      listener:(context,state){
       /* if(state is SuccessGetUserData){
          nameController.text=state.loginModel.data!.name!;
          emailController.text=state.loginModel.data!.email!;
          phoneController.text=state.loginModel.data!.phone!;
        } */
      } ,
      builder:(context,state){
        var model=MainCubit.get(context).userdata;
        nameController.text=model.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;
        return ConditionalBuilder(
          condition: MainCubit.get(context).userdata != null,
          builder: (context) =>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CoustomTextForm(
                    validator: (data) {
                      if (data!.isEmpty) {
                        return "Please Enter your Name ";
                      } else {
                        return null;
                      }
                    },
                    prefIcon: Icons.person,
                    prefIconColor: Colors.blue,
                    controller: nameController,
                    passwordText: false,
                    label: "User Name",
                    text: TextInputType.name,
                    museTextColor: Colors.white,
                    borderColor: Colors.blue,
                    borderReduse: 10,
                    labelColor: Colors.grey,
                    userTextColor: Colors.blue),
                SizedBox(height: 20,),
                CoustomTextForm(
                    validator: (data) {
                      if (data!.isEmpty) {
                        return "Please Enter your Email Address";
                      } else {
                        return null;
                      }
                    },
                    prefIcon: Icons.email,
                    prefIconColor: Colors.blue,
                    controller: emailController,
                    passwordText: false,
                    label: "User Email",
                    text: TextInputType.emailAddress,
                    museTextColor: Colors.white,
                    borderColor: Colors.blue,
                    borderReduse: 10,
                    labelColor: Colors.grey,
                    userTextColor: Colors.blue),
                SizedBox(height: 20,),
                CoustomTextForm(
                    validator: (data) {
                      if (data!.isEmpty) {
                        return "Please Enter your Phone";
                      } else {
                        return null;
                      }
                    },
                    prefIcon: Icons.phone,
                    prefIconColor: Colors.blue,
                    controller: phoneController,
                    passwordText: false,
                    label: "User Phone",
                    text: TextInputType.phone,
                    museTextColor: Colors.white,
                    borderColor: Colors.blue,
                    borderReduse: 10,
                    labelColor: Colors.grey,
                    userTextColor: Colors.blue),
                SizedBox(height: 20,),
                coustomBottom(
                    textColor: Colors.white,
                    bgColor: Colors.blue,
                    text: "Logout",
                    onTap: () {
                      SignOut(context);
                    }
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      } ,
    );
  }
}
