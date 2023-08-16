class SearchModel{
  bool? status;
  GetData? data;
  SearchModel.fromjson(Map<String,dynamic> json){
    status = json["status"];
    data =json["data"]!= null ? GetData.fromJson(json["data"]) : null;

  }
}

class GetData{
  int? currentpage;
  late List<Product> data = [];

  GetData.fromJson(Map<String,dynamic> json){
    currentpage = json["current_page"];
    for (var x in json["data"]) {
      data.add(Product.fromjson(x));
    }
  }

}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  Product.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];

  }
}