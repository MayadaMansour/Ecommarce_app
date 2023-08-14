import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommarce_app/main_cubit/cubit/main_cubit.dart';
import 'package:ecommarce_app/models/categories_model.dart';
import 'package:ecommarce_app/models/home_model.dart';
import 'package:ecommarce_app/widgets/coustoms/coustom_toast.dart';
import 'package:ecommarce_app/widgets/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if(state is SuccessFavoritesData){
          if(state.model.status == false){
            coustomToast(text: state.model.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: MainCubit.get(context).homeModel != null &&
                MainCubit.get(context).categorisModel != null,
            builder: (context) => ProductsBuilder(
                MainCubit.get(context).homeModel!,
                MainCubit.get(context).categorisModel!,
                context),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget ProductsBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage("${e.image}"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 150,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Categoris",
                    style: TextStyle(color: defaultColor, fontSize: 26),
                  ),
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            categoryItem(categoriesModel.data!.data[index]),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemCount: categoriesModel.data!.data.length),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "New Products",
                    style: TextStyle(color: defaultColor, fontSize: 26),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1 / 1.55,
                children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        gridProducts(model.data!.products[index], context)),
              ),
            ),
          ],
        ),
      );

  Widget gridProducts(ProductsModel model, context) => Container(
        color: Colors.white,
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.network(
                  model.image!,
                  height: 200,
                  width: double.infinity,
                ),
                if (model.discount != 0)
                  const Text(
                    "Discount",
                    style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.red,
                        fontSize: 15),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, height: 1.2),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "${model.price!.round()}",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: defaultColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "${model.oldPrice!.round()}",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    MainCubit.get(context).changeFavorites(model.id!);
                     print(model.id);
                  },
                  icon: MainCubit.get(context).favorites[model.id]!
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 25,
                        )
                      : const Icon(
                          Icons.favorite,
                          color: Colors.grey,
                          size: 25,
                        ),
                )
              ],
            ),
          ]),
        ]),
      );

  Widget categoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.network(height: 100, width: 100, "${model.image}"),
          Container(
            height: 20,
            width: 100,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
            child: Text(
              "${model.name}",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          )
        ],
      );
}
