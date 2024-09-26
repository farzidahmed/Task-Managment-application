import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment/global_widget/background_image.dart';
import 'package:task_managment/utills/apps_colors.dart';

import 'forgot_pass_otp.dart';
import 'sign_in_screen.dart';

class ForgotPasswordEmail extends StatefulWidget {
  const ForgotPasswordEmail({super.key});

  @override
  State<ForgotPasswordEmail> createState() => _SignInScreenForgotPasswordEmailState();
}

class _SignInScreenForgotPasswordEmailState extends State<ForgotPasswordEmail> {
  @override
  Widget build(BuildContext context) {
    TextTheme texttheme = Theme.of(context).textTheme;
    return  Scaffold(
      resizeToAvoidBottomInset: false,
        body: BackgroundImage(child:
        Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 10.0,
                bottom: 10.1+MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Email Address",style: texttheme.displaySmall?.
                  copyWith(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 16,),
                  Text("A 6 digits verification otp will be sent to your emaill address",
                    style: texttheme.titleSmall?.
                  copyWith(color: Colors.grey),),
                  const SizedBox(height:20),
                  _buildforgotPassForm(),  //return widgrt method signin form
                  const SizedBox(height:48),
                  Center(
                    child: Column(
                      children: [
                        _buildforgotPassSection()// return widget method sign up button
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
        )
    );
  }




// textformfiled er text
  Widget _buildforgotPassForm (){
    return    Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              hintText: "Email"
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
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassOtp()));
    // TODO:implementation on tap next page
  }

  // don't have an account er text
  Widget  _buildforgotPassSection(){
    return  RichText(text:  TextSpan(
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 0.5
        ),
        text: "Have an account ?",
        children: [
          TextSpan(
              text: "Sign In ",
              style: TextStyle(color: Appscolor.themecolor),
              recognizer: TapGestureRecognizer()
                ..onTap = _onTapforgotPass
          )
        ]
    ));
  }

  // click signup page button and goto next page
  void _onTapforgotPass(){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SignInScreen()));
  }


}
