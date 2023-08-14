import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommarce_app/main_cubit/cubit/main_cubit.dart';
import 'package:ecommarce_app/models/get_favorite_model.dart';
import 'package:ecommarce_app/widgets/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return ConditionalBuilder(
            condition: state is ! LoadingGetFavoritesData,
            builder:(context) =>  ListView.separated(
                physics:const BouncingScrollPhysics(),
                itemBuilder: (context, index) => favoritesContaner(cubit.getFavorites!.data!.data[index].products!, context),
                separatorBuilder:(context, index) => const Divider(
                    color: Colors.grey,
                    endIndent: 50,
                    indent: 50,
                    height: 0.5,
                    thickness: 1),
                itemCount: cubit.getFavorites!.data!.data.length),
            fallback:(context) =>const Center(child: CircularProgressIndicator()
              ,)
        );
      },
    );
  }

  Widget favoritesContaner(DetilsDataAll data , context) => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          height: 120,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 140,
                  width: 120,
                  child: Image.network(
                      data.image!),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: Text(
                      data.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                      " ${data.price.toString()}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,color: defaultColor
                      )),
                  if (data.discount!= 0)
                    Text(
                        " ${data.oldPrice.toString()}",
                        style: const TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough)),
                  if (data.discount != 0)
                    Text(
                        "Discount : ${data.discount}",
                        style: const TextStyle(
                            fontSize: 15, color: Colors.red)),
                ],
              )
            ],
          ),
        ),
      ),
      if (data.discount != 0)
        Padding(
          padding: EdgeInsets.only(left: 30, bottom: 15),
          child: Text(
            "Discount",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                backgroundColor: Colors.red,
                fontSize: 14),
          ),
        ),
      Padding(
        padding: const EdgeInsets.only(top: 80,left: 320),
        child: IconButton(
            onPressed: () {
              MainCubit.get(context).changeFavorites(data.id!);
            },
            icon: MainCubit.get(context).favorites[data.id]!?
            const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 20,
            ) :const Icon(
              Icons.favorite,
              color: Colors.grey,
              size: 20,
            ) ),
      ),
    ],
  );
}