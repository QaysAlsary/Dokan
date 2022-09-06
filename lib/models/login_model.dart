class LoginModel {
  bool? status;
  String? message;
  UserData? data;
  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  String? name, email, phone, image, token;
  int? id, points, credit;

//   UserData({
//     this.name,
//     this.email,
//     this.phone,
//     this.image,
//     this.token,
//     this.id,
//     this.points,
//     this.credit,
//
// });
  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
    id = json['id'];
    points = json['points'];
    credit = json['credit'];
  }
}
