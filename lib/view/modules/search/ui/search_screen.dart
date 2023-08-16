import 'package:ecommarce_app/main_cubit/cubit/main_cubit.dart';
import 'package:ecommarce_app/models/get_favorite_model.dart';
import 'package:ecommarce_app/models/search_model.dart';
import 'package:ecommarce_app/view/modules/search/cubit/search_cubit.dart';
import 'package:ecommarce_app/view/modules/search/cubit/search_state.dart';
import 'package:ecommarce_app/widgets/coustoms/coustom_text_form.dart';
import 'package:ecommarce_app/widgets/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget{
  var formKey=GlobalKey<FormState>();
  var SearchController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchState>(
        listener:(context,state) {
        } ,
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,

            ),
            body:  Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CoustomTextForm(
                      controller: SearchController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Text Search";
                        }
                        return null;
                      },
                      label: "Search",
                      text: TextInputType.text,
                      museTextColor: Colors.black,
                      borderColor: Colors.blue,
                      borderReduse: 30,
                      labelColor: Colors.blue,
                      userTextColor: Colors.black,
                     onSubmitt: (String text){
                        SearchCubit.get(context).Search(text);
                     },
                      prefIcon: Icons.search,
                      prefIconColor: Colors.blue,
                      suffixIconeColor: Colors.blue,
                      passwordText: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            physics:const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => searchContaner(SearchCubit.get(context).model!.data!.data[index] , context,isOldPrise: false),
                            separatorBuilder:(context, index) => const Divider(
                                color: Colors.grey,
                                endIndent: 50,
                                indent: 50,
                                height: 0.5,
                                thickness: 1),
                            itemCount: SearchCubit.get(context).model!.data!.data.length),
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
  Widget searchContaner( model , context,{bool isOldPrise =true}) => Stack(
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
                  width: 70,
                  child: Image.network(
                      model.image!),
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
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                      " ${model.price.toString()}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,color: defaultColor
                      )),
                  if (model.discount!= 0 && isOldPrise)
                    Text(
                        " ${model.oldPrice.toString()}",
                        style: const TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough)),
                  if (model.discount != 0 && isOldPrise)
                    Text(
                        "Discount : ${model.discount}",
                        style: const TextStyle(
                            fontSize: 15, color: Colors.red)),
                ],
              )
            ],
          ),
        ),
      ),
      if (model.discount != 0 && isOldPrise)
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
        padding: const EdgeInsets.only(bottom: 20,left: 300),
        child: IconButton(
            onPressed: () {
              MainCubit.get(context).changeFavorites(model.id!);
            },
            icon: MainCubit.get(context).favorites[model.id]!?
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