//note: http pakeage holo 3rd party api caller
//api theke jah amra pai taholo decode kora r ja dei ta hoilo encode
// api er bodyte jodi data pathate hoy tahole key value(Map) use hoy
// try catch use kora hoy app ta crash hoyar theke bacate

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_managment/controller/auth_controller.dart';
import 'package:task_managment/task_managment.dart';
import 'package:task_managment/views/Auth_screen/sign_in_screen.dart';

import '../models/network_responce.dart';

class NetworkCaller {
  //bar bar jate network response er instance create kora nah lage sei jnno amra static keywork bebohar kori
// api get korar jonno
// get/ post request a named{}use kora hoy jeno amra dekhte pari kih data pathano hoy
  static Future<NetworkResponse> getRequest( {required String url}) async {
    try {
      //kih data gelo ta check korar jonno
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': AuthController.accessToken.toString(),
      };
      debugPrint("$url");
      final Response response = await get(uri,headers: headers);
      printDebug(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          responseData: decodeData,
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 401) {
        _movetologin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errormessege: 'Unauthenticated!');
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errormessege: e.toString(),
      );
    }
  }

  //api post korar jonno
  static Future<NetworkResponse> postRequest(
      {required String url,
      Map<String, dynamic>? body,
       }) async {
    try {
      //api te kih data gelo ta check korar jonno
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': AuthController.accessToken.toString(),
      };
      // debugPrint("$url");
      printReequest(url, body, headers);
      final Response response =
          await post(uri, body: jsonEncode(body), headers: headers);
      printDebug(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        if (decodeData['status'] == 'fail') {
          return NetworkResponse(
              isSuccess: false,
              statusCode: response.statusCode,
              errormessege: decodeData['data']);
        }
        return NetworkResponse(
          isSuccess: true,
          responseData: decodeData,
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 401) {
        _movetologin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errormessege: 'Unauthenticated!');
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errormessege: e.toString(),
      );
    }
  }

  static void printReequest(
      String url, Map<String, dynamic>? body, Map<String, dynamic>? headers) {
    //ai debug er korar karon holo jate amra dekhte console kih data aslo
    debugPrint("REQUEST:\nURL$url\nBody:$body\nHeaders:$headers");
  }

  static void printDebug(String url, Response response) {
    //ai debug er korar karon holo jate amra dekhte console kih data aslo
    debugPrint(
        "URL$url\nResponse:${response.statusCode}\nBody:${response.body}");
  }

  static Future<void> _movetologin() async {
    await AuthController.clearUserdata();
    Navigator.pushAndRemoveUntil(TaskManagment.navigatorkey.currentContext!,
        MaterialPageRoute(builder: (context) => SignInScreen()), (p) => false);
  }
}
