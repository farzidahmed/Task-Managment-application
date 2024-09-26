import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment/global_widget/background_image.dart';
import 'package:task_managment/utills/apps_colors.dart';
import 'package:task_managment/views/forgot_password_email.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme texttheme = Theme.of(context).textTheme;
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundImage(child:
      Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: 10.0,right: 10.0,
              top: 10.0,bottom: 10.0+MediaQuery.of(context).viewInsets.bottom
          ),
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Get Started With",style: texttheme.displaySmall?.
                  copyWith(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 16,),
                  _buildSigninForm(),  //return widgrt method signin form
                  const SizedBox(height:20),

                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: _onTapForgotButton,
                            child: const Text("Forgot password",style: TextStyle(color:Colors.grey),)),
                        _buildSigninSection()// return widget method sign up button
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
      )
    );
  }




// textformfiled er text
  Widget _buildSigninForm (){
    return    Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              hintText: "Email"
          ),
        ),
        const SizedBox(height: 16,),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              hintText: "Password"
          ),
        ),
        const SizedBox(height: 16,),
        ElevatedButton(
            onPressed:_onTapNextPage,
            child: const Icon(Icons.arrow_circle_right_outlined)),
      ],
    );
  }

  void _onTapNextPage(){
    // TODO:implementation on tap next page
  }

  // click this button and go forgot page

  void _onTapForgotButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordEmail()));
    // TODO: implemnet on tap forgot password
  }

  // don't have an account er text
  Widget  _buildSigninSection(){
    return  RichText(text:  TextSpan(
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 0.5
        ),
        text: "Don't have an account ?",
        children: [
          TextSpan(
              text: "Sign Up ",
              style: TextStyle(color: Appscolor.themecolor),
            recognizer: TapGestureRecognizer()
      ..onTap = _onTapSignUp
          )
        ]
    ));
  }

  // click signup page button and goto next page
void _onTapSignUp(){
  Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen()));
}


}
