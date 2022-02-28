class CategoriesModel{
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String , dynamic> json){
    status=json['status'];
    data=CategoriesDataModel.fromJson(json['data']);
  }

}

class CategoriesDataModel{
  int? current_page;
  List<DataModel> data=[];
  CategoriesDataModel.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element) {
      data.add(DataModel.feomJson(element));
    });
    current_page=json['current_page'];
  }
}

class DataModel{
  int? id;
  String? name;
  String? image;
  DataModel.feomJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}
