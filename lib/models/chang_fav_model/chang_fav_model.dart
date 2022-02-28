class ChangFavouritesModel{
  bool? status;
  String? message;
  ChangFavouritesModel.fromJson(Map<String , dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}