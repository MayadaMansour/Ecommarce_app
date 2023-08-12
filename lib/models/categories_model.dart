class CategoriesModel{
  bool ?status;
  CategoriesDataModel? data;

  CategoriesModel.fromjson(Map<String,dynamic> json){
    status = json["status"];
    data =CategoriesDataModel.fromJason(json["data"]);
  }

}

class CategoriesDataModel{
  int? currentpage;
  late List<DataModel> data = [];

  CategoriesDataModel.fromJason(Map<String,dynamic> json){
    currentpage = json["current_page"];
    for (var x in json["data"]) {
      data.add(DataModel.fromjson(x));
    }
  }

}

class DataModel {
  int? id;
  String? image;
  String? name;
  DataModel.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    name = json["name"];
  }
}