class HomeModel{
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String , dynamic> json){
    status=json['status'];
    data=HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel{
  List<BannerModel> banners=[];
  List<ProductModel>products=[];
  HomeDataModel.fromJson(Map<String,dynamic> json){
       json['banners'].forEach((elemnt){
         banners.add(BannerModel.fromJson(elemnt));
       });
       json['products'].forEach((elemmt){
         products.add(ProductModel.fromJson(elemmt));
       });
  }
}

class BannerModel{
  int? id;
  String? image ;
  BannerModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}
class ProductModel{
  int? id;
  dynamic price;
  dynamic  old_price;
  dynamic discount;
  String? image;
  String? name;
  late bool in_favorites;
  bool? in_cart;
  ProductModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_favorites=json['in_favorites'] !=null;
    in_cart=json['in_cart'];

  }
}