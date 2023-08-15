import 'package:ecommarce_app/view/modules/register/cubit/register_cubit.dart';
import 'package:ecommarce_app/view/modules/register/cubit/register_state.dart';
import 'package:ecommarce_app/widgets/coustoms/coustom_bottom.dart';
import 'package:ecommarce_app/widgets/coustoms/coustom_text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterScreen extends StatelessWidget{

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formKey,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/356802111_744944093988066_4601010985411673406_n.jpg"))),
                      ),
                    ),
                     SizedBox(
                      height: 30,
                    ),
                    CoustomTextForm(
                      controller: nameController,
                      validator: (data) {
                        if (data!.isEmpty) {
                          return "field your name";
                        }
                        return null;
                      },
                      label: "Your Name",
                      text: TextInputType.text,
                      museTextColor: Colors.blue,
                      borderColor: Colors.blue,
                      borderReduse: 30,
                      labelColor: Colors.blue,
                      userTextColor: Colors.blue,
                      prefIcon: Icons.person,
                      prefIconColor: Colors.blue,
                      passwordText: false,
                    ),
                     SizedBox(
                      height: 20,
                    ),
                    CoustomTextForm(
                      controller: emailController,
                      validator: (data) {
                        if (data!.isEmpty) {
                          return "field your Email";
                        }
                        return null;
                      },
                      label: "Email",
                      text: TextInputType.emailAddress,
                      museTextColor: Colors.blue,
                      borderColor: Colors.blue,
                      borderReduse: 30,
                      labelColor: Colors.blue,
                      userTextColor: Colors.blue,
                      prefIcon: Icons.email_outlined,
                      prefIconColor: Colors.blue,
                      passwordText: false,
                    ),
                     SizedBox(
                      height: 20,
                    ),
                    CoustomTextForm(
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "field your Number";
                        }
                        return null;
                      },
                      label: "Your Phone Number",
                      text: TextInputType.number,
                      museTextColor: Colors.blue,
                      borderColor: Colors.blue,
                      borderReduse: 30,
                      labelColor: Colors.blue,
                      userTextColor: Colors.blue,
                      prefIcon: Icons.phone_android_outlined,
                      prefIconColor: Colors.blue,
                      passwordText: false,
                    ),
                     SizedBox(
                      height: 20,
                    ),
                    CoustomTextForm(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "field your password";
                        }
                        return null;
                      },
                      passwordText: cubit.showPassword,
                      label: "New Password",
                      text: TextInputType.visiblePassword,
                      museTextColor: Colors.blue,
                      borderColor: Colors.blue,
                      borderReduse: 30,
                      labelColor: Colors.blue,
                      userTextColor: Colors.blue,
                      suffixIcone: IconButton(
                          onPressed: () {
                            cubit.changeIcona();
                          },
                          icon: cubit.showPassword
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined)),
                      prefIcon: Icons.lock,
                      prefIconColor: Colors.blue,
                      suffixIconeColor: Colors.blue,
                    ),
                     SizedBox(
                      height: 30,
                    ),
                    coustomBottom(
                        textColor: Colors.blue,
                        bgColor: Colors.grey.shade300,
                        onTap: (){
                          if (formKey.currentState!.validate()){

                          }
                        },
                        text: "REGISTER"
                    ),
                     SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(
                          "You Have Account ?",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
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
