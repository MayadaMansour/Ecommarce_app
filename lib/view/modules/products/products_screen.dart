import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommarce_app/main_cubit/cubit/main_cubit.dart';
import 'package:ecommarce_app/models/home_model.dart';
import 'package:ecommarce_app/widgets/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: MainCubit.get(context).homeModel != null,
            builder: (context) =>
                ProductsBuilder(MainCubit.get(context).homeModel!),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget ProductsBuilder(HomeModel model) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
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
                height: 200,
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
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1 / 1.55,
                children: List.generate(model.data!.products.length,
                    (index) => gridProducts(model.data!.products[index])),
              ),
            ),
          ],
        ),
      );

  Widget gridProducts(ProductsModel model) => Container(
        color: Colors.white,
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
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
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      size: 20,
                    ))
              ],
            ),
          ]),
        ]),
      );
}