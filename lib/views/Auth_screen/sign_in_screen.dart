import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment/api_controlls/models/login_model.dart';
import 'package:task_managment/api_controlls/models/network_responce.dart';
import 'package:task_managment/api_controlls/services/network_caller.dart';
import 'package:task_managment/global_widget/background_image.dart';
import 'package:task_managment/global_widget/navbar_screen.dart';
import 'package:task_managment/global_widget/snakbar_message.dart';
import 'package:task_managment/utills/apps_colors.dart';
import 'package:task_managment/utills/urls.dart';
import 'package:task_managment/views/Auth_screen/forgot_password_email.dart';

import '../../controller/auth_controller.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _textEmailController = TextEditingController();
  final TextEditingController _textPasswordController = TextEditingController();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    TextTheme texttheme = Theme.of(context).textTheme;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BackgroundImage(
            child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 10.0,
                bottom: 10.0 + MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Get Started With",
                      style: texttheme.displaySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildSigninForm(), //return widgrt method signin form
                    const SizedBox(height: 20),

                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: _onTapForgotButton,
                              child: const Text(
                                "Forgot password",
                                style: TextStyle(color: Colors.grey),
                              )),
                          _buildSigninSection()
                          // return widget method sign up button
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )));
  }

// textformfiled er text
  Widget _buildSigninForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _textEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
            validator: (String? value) {
              if (value?.isEmpty == true) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _textPasswordController,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Password"),
            validator: (String? value) {
              if (value?.isEmpty == true) {
                return 'Enter a valid email';
              } else if (value!.length == 6) {
                return 'Enter a password more then 6 letters';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Visibility(
            visible: !_inProgress,
            replacement: const CircularProgressIndicator(),
            child: ElevatedButton(
                onPressed: _onTapNextPage,
                child: const Icon(Icons.arrow_circle_right_outlined)),
          ),
        ],
      ),
    );
  }

  void _onTapNextPage() {
    // TODO:implementation on tap next page
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _signin();
  }

//api caller
  Future<void> _signin() async {
    _inProgress = true;
    setState(() {});
    Map<String,dynamic> requestbody={
      "email":_textEmailController.text.trim(),//trim kora hoy first and last er otirikto ongsho kete felar jonno
      "password":_textPasswordController.text

    };
    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.login,
            body: requestbody,
           );
    _inProgress = true;
    setState(() {});
    //then ckh korbo response success ki nah ...
    // jodi success hoy tahole navigator kore dibo
    if(response.statusCode==200){
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessData(loginModel.token!);//response datate je token ta ache oita amra save korbo
      await AuthController.saveUserdata(loginModel.data!);//response datate je token ta ache oita amra save korbo
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavbarScreen()),
              (value) => false);
    }else{
      // jodi success nah hoy tahole
      snakbarmessage(context, response.errormessege,true);
    }


  }

  // click this button and go forgot page

  void _onTapForgotButton() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForgotPasswordEmail()));
    // TODO: implemnet on tap forgot password
  }

  // don't have an account er text
  Widget _buildSigninSection() {
    return RichText(
        text: TextSpan(
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 0.5),
            text: "Don't have an account ?",
            children: [
          TextSpan(
              text: "Sign Up ",
              style: const TextStyle(color: Appscolor.themecolor),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignUp)
        ]));
  }

  // click signup page button and goto next page
  void _onTapSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }
}
