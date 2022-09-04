class ChangeFavoritesModel{
  late bool status;
  String? message;
  ChangeFavoritesModel.formJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];

  }
}