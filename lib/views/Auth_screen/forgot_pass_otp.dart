import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_managment/global_widget/background_image.dart';
import 'package:task_managment/utills/apps_colors.dart';
import 'package:task_managment/views/Auth_screen/reset_password.dart';

import 'sign_in_screen.dart';


class ForgotPassOtp extends StatefulWidget {
  const ForgotPassOtp({super.key});

  @override
  State<ForgotPassOtp> createState() => _ForgotPassOtpState();
}

class _ForgotPassOtpState extends State<ForgotPassOtp> {
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
                bottom: 10.0+MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("PIN Verification",style: texttheme.displaySmall?.
                  copyWith(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 16,),
                  Text("A 6 digits verification otp has been sent to your emaill address",
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
        PinCodeTextField(
          keyboardType: TextInputType.number,
          length: 6,
          obscureText: true,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
              selectedColor: Colors.white,
            inactiveColor: Colors.white,
            inactiveFillColor:Colors.white ,
          ),
          animationDuration: Duration(milliseconds: 300),
          // backgroundColor: Colors.blue.shade50,
          backgroundColor: Colors.transparent,

          enableActiveFill: true,
           appContext: context,
        ),
         SizedBox(height: 16,),
        ElevatedButton(
            onPressed:_onTapNextPage,
            child: const Icon(Icons.arrow_circle_right_outlined)),
      ],
    );
  }

  void _onTapNextPage(){
    // TODO:implementation on tap next page
    Navigator.push(context,MaterialPageRoute(builder: (context)=>const ResetPassword()));
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
   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const SignInScreen()),
           (_)=>false);
  }


}
