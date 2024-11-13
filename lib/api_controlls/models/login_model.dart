import 'package:task_managment/api_controlls/models/login_user_model.dart';

class LoginModel {
  String? status;
  UserModel? data;
  String? token;

  LoginModel({this.status, this.data, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
    token = json['token'];
  }

}

