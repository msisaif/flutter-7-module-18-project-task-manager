import 'package:task_manager/data/models/user_model.dart';

class LoginModel {
  String? status;
  UserModel? data;  // Change from List<UserModel>? to UserModel?
  String? token;

  LoginModel({this.status, this.data, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    // Check if data is not null and is a Map
    if (json['data'] != null && json['data'] is Map<String, dynamic>) {
      data = UserModel.fromJson(json['data']);
    }

    token = json['token'];
  }
}
