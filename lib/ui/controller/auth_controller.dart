import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/api_controlls/models/login_user_model.dart';

class AuthController {
  static const String _accessTokenKey = "access-token";
  static const String _userDatakey = "userdata";

  //bar bar get ba awit korar theke bacte amra global variable create kore rakhlam
  static String?accessToken;
  static UserModel? userdata;

  static Future<void> saveAccessData(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey,
        token);// তুমি যদি কোনো access token বা user ID সংরক্ষণ করতে চাও যা স্ট্রিং ফরম্যাটে থাকে, তখন setString ব্যবহার করতে হবে।
    accessToken = token;// jokhon accesToken save korte asbe tokhon token call korbe
  }

  static Future<void> saveUserdata(UserModel usermodel) async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDatakey, jsonEncode(usermodel.toJson()));
    userdata = usermodel;
  }

// String return korar holo jodi key jodi nah pay thaole thakbe null

  static Future<String?> getAccessData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey,
    ); //getString ব্যবহার করা হয় SharedPreferences থেকে সংরক্ষিত ডেটা (string ফরম্যাটে) রিট্রিভ করার জন্য।
  accessToken=token;
  return token; // je token paichii oita retun kore dibo
  }

  static Future<UserModel? > getUserData ()async {
    SharedPreferences sharedPreferences =await SharedPreferences .getInstance();
    String? userencodeData = sharedPreferences.getString(_userDatakey);
    if(userencodeData==null){
      return null;
    }
    UserModel userModel = UserModel.fromJson(jsonDecode(userencodeData));
    userdata=userModel;
  return userModel;
  }
  //jodi aita true thake tahole null return korben otherwise false return krbe
  static bool isLoggedIn(){
    return accessToken!=null;
  }

// jodi amra log out kori tahole sob data clear kore dibe
  static Future<void> clearUserdata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear(); // shared preference a string set korar jonno setString bebohar kora hoiche
      accessToken=null;
  }

  }

