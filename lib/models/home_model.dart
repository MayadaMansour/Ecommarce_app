class HomeModel {
  bool ?status;
  HomeDataModel? data;
  HomeModel.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data = HomeDataModel.fromjson(json["data"]);
  }
}

class HomeDataModel {
  late List<BannerModel> banners = [];
  late List<ProductsModel> products = [];
  HomeDataModel.fromjson(Map<String, dynamic> json) {
    for (var x in json["banners"]) {
      banners.add(BannerModel.fromjson(x));
    }
    for (var x in json["products"]) {
      products.add(ProductsModel.fromjson(x));
    }
  }
}

class BannerModel{
  int? id;
  String? image;
  BannerModel.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
   }
 }

class ProductsModel{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool ?inFavorites;
  bool? inCart;

  ProductsModel.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
  }
}