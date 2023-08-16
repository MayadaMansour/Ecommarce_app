import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommarce_app/constans.dart';
import 'package:ecommarce_app/data/local/cache_helper.dart';
import 'package:ecommarce_app/view/modules/home/home_screen.dart';
import 'package:ecommarce_app/view/modules/login/cubit/cubit_login.dart';
import 'package:ecommarce_app/view/modules/login/cubit/states.dart';
import 'package:ecommarce_app/view/modules/register/ui/register_screen.dart';
import 'package:ecommarce_app/widgets/coustoms/coustom_bottom.dart';
import 'package:ecommarce_app/widgets/coustoms/coustom_text_form.dart';
import 'package:ecommarce_app/widgets/coustoms/coustom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              CachHelper.saveData(
                  key: "saveToken", value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                 Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) =>  HomeScreen()),
                    (route) => false);
              });
            } else {
              coustomToast(
                  text: state.loginModel.message.toString(),
                  state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Text("LOGIN",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 25),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,

            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/356802111_744944093988066_4601010985411673406_n.jpg")
                                )),
                          ),
                        ),
                         SizedBox(
                          height: 30,
                        ),
                        CoustomTextForm(
                            validator: (data) {
                              if (data!.isEmpty) {
                                return "Please Enter your Email Address";
                              } else {
                                return null;
                              }
                            },
                            prefIcon: Icons.email_outlined,
                            prefIconColor: Colors.blue,
                            controller: emailController,
                            passwordText: false,
                            label: "Email",
                            text: TextInputType.emailAddress,
                            museTextColor: Colors.white,
                            borderColor: Colors.blue,
                            borderReduse: 10,
                            labelColor: Colors.grey,
                            userTextColor: Colors.black),
                         SizedBox(
                          height: 20,
                        ),
                        CoustomTextForm(
                            validator: (data) {
                              if (data!.isEmpty) {
                                return "Password is too Short";
                              } else {
                                return null;
                              }
                            },
                            suffixIcone: IconButton(
                              onPressed: () {
                                cubit.changeIcona();
                              },
                              icon: cubit.showPassword
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined),
                            ),
                            suffixIconeColor: Colors.blue,
                            prefIconColor: Colors.blue,
                            prefIcon: Icons.lock_outline,
                            controller: passwordController,
                            passwordText: cubit.showPassword,
                            label: "Password",
                            text: TextInputType.visiblePassword,
                            museTextColor: Colors.grey,
                            borderColor: Colors.blue,
                            borderReduse: 10,
                            labelColor: Colors.grey,
                            userTextColor: Colors.black),
                         SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => coustomBottom(
                              textColor: Colors.white,
                              bgColor: Colors.blue,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.usersLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: "LOGIN"),
                          fallback: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              )),
                        ),
                         SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don`t Have Account ?",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShopRegisterScreen(),
                                    ));
                              },
                              child: const Text(
                                "Register Now",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}