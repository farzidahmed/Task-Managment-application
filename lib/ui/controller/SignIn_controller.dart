import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/api_controlls/models/login_model.dart';
import '../../data/api_controlls/models/network_responce.dart';
import '../../data/api_controlls/services/network_caller.dart';
import '../global_widget/navbar_screen.dart';
import '../utills/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController{
  bool _inProgress = false;
  String? _errorMesseage;
  String? get errorMesseage=>_errorMesseage;
  bool get inprogress => _inProgress;

  Future<bool> signin(String email , password) async {
    bool isSuccess = false;
    _inProgress = true;
  update();

    Map<String, dynamic> requestbody = {
      "email": email,
      //trim kora hoy first and last er otirikto ongsho kete felar jonno
      "password": password.text
    };
    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.login,
      body: requestbody,
    );

    //then ckh korbo response success ki nah ...
    // jodi success hoy tahole navigator kore dibo
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessData(loginModel
          .token!); //response datate je token ta ache oita amra save korbo
      await AuthController.saveUserdata(loginModel
          .data!); //response datate je token ta ache oita amra save korbo
     isSuccess=true;
    } else {
      // jodi success nah hoy tahole
     _errorMesseage=response.errormessege;
    }
    _inProgress = true;
    update();
    return isSuccess;
  }
}