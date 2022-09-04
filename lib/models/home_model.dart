class HomeModel{
  bool? status;
  HomeDataModel? data;
  HomeModel.formJson(Map<dynamic,dynamic>json){
 status = json['status'];
 data = HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel{
  List<dynamic> banners=[];
  List<dynamic> products=[];
  HomeDataModel.fromJson(Map<dynamic,dynamic>json){
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}
class BannerModel{
  int? id;
  String? image;
  BannerModel.fromJson(Map<dynamic,dynamic>json){
    id= json['id'];
    image= json['image'];
  }
}
class ProductModel{
  int? id;
  dynamic price,old_price,discount;
  String? image,name;
  bool? in_favorites,in_cart;
  ProductModel.fromJson(Map<dynamic,dynamic>json){
  id=json['id'];
  price=json['price'];
  old_price=json['old_price'];
  discount=json['discount'];
  name=json['name'];
  image=json['image'];
  in_favorites=json['in_favorites'];
  in_cart=json['in_cart'];
  }
}