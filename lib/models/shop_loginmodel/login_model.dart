class ShopLoginModel{
bool? status;
String? message;
LoginDataModel? data;
ShopLoginModel.fromJson(Map<String, dynamic> json){
  status=json['status'];
  message=json['message'];
  data=LoginDataModel.fromJson(json['data']);
}
}

class LoginDataModel{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  LoginDataModel.fromJson(Map<String , dynamic>json){
  id =json['id'];
  name =json['name'];
  email=json['email'];
  phone =json['phone'];
  image =json['image'];
  points =json['points'];
  credit =json['credit'];
  token =json['token'];

  }
}