//note: http pakeage holo 3rd party api caller
//api theke jah amra pai taholo decode kora r ja hei ta hoilo encode

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:task_managment/api_controlls/models/network_responce.dart';
import 'package:http/http.dart';

class NetworkCaller{
  //bar bar jate network response er instance create kora nah lage sei jnno amra static keywork bebohar kori
// api get korar jonno
  static Future<NetworkResponse?> getRequest(String url)async{
    try{
      //kih data gelo ta check korar jonno
      Uri uri = Uri.parse(url);
      debugPrint("$url");
      final Response response = await get(uri);
      printDebug(url,response);
      if(response.statusCode==200){
        final decodeData =jsonDecode(response.body);
        return  NetworkResponse(
          isSuccess: true,
          responseData: decodeData,
          statusCode: response.statusCode,
        );
      }else{
        return  NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    }catch(e){
      return  NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errormessege: e.toString(),
      );
    }

  }
  //api post korar jonno
  static Future<NetworkResponse?> postRequest(String url)async{
    try{
      //kih data gelo ta check korar jonno
      Uri uri = Uri.parse(url);
      debugPrint("$url");
      final Response response = await post(uri,
          headers: {'Content-Type':'application/json'}
      );
      printDebug(url,response);
      if(response.statusCode==200){
        final decodeData =jsonEncode(response.body);
        return  NetworkResponse(
          isSuccess: true,
          responseData: decodeData,
          statusCode: response.statusCode,
        );
      }else{
        return  NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    }catch(e){
      return  NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errormessege: e.toString(),
      );
    }

  }

  static void printDebug(String url,Response response){
    //ai debug er korar karon holo jate amra dekhte console kih data aslo
    debugPrint("URL$url\nResponse:${response.statusCode}\nBody:${response.body}");
  }
}