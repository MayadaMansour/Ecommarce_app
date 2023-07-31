import 'package:ecommarce_app/view/modules/home/cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                  /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                         // builder: (context) => const Search(),
                        ));*/
                  },
                  icon: const Icon(
                    Icons.search_outlined,
                    color: Colors.blue,
                  ))
            ],
            title: const Text(
              "Shopping",
              style: TextStyle(color: Colors.blue),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                cubit.changeIcon(value);
              },
              currentIndex: cubit.index,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined,),
                  label: "Home",

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps_outlined,),
                  label: "Category",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline,),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings,),
                  label: "Setting",
                ),
              ]),
         // body: cubit.screens[cubit.index],
        );
      },
    );
  }
}
