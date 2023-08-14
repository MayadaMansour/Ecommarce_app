class GetFavorite{
  bool? status;
  GetData? data;
  GetFavorite.fromjson(Map<String,dynamic> json){
    status = json["status"];
    data =json["data"]!= null ? GetData.fromJson(json["data"]) : null;

  }
}

class GetData{
  int? currentpage;
  late List<DetailsData> data = [];

  GetData.fromJson(Map<String,dynamic> json){
    currentpage = json["current_page"];
    for (var x in json["data"]) {
      data.add(DetailsData.fromjson(x));
    }
  }

}

class DetailsData{
  int? id;
  DetilsDataAll? products;
  DetailsData.fromjson(Map<String,dynamic> json){
    id=json["id"];
    products = DetilsDataAll.fromjson(json["product"]);

  }
}

class DetilsDataAll{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  DetilsDataAll.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];

  }
}