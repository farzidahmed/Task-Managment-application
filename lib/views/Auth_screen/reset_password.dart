import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment/global_widget/background_image.dart';
import 'package:task_managment/utills/apps_colors.dart';

import 'forgot_pass_otp.dart';
import 'sign_in_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final TextEditingController _oldpasswordController=TextEditingController();
  final TextEditingController _newpasswordController=TextEditingController();

   final GlobalKey<FormState> _formkey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextTheme texttheme = Theme.of(context).textTheme;
    return  Scaffold(
      resizeToAvoidBottomInset: false,
        body: BackgroundImage(child:
        Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10.0,
                top: 10.0,
                right: 10.0,
                bottom: 10.0+MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Set Password",style: texttheme.displaySmall?.
                  copyWith(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 16,),
                  Text("Minimum length password 8 character with Latter and number combination",
                    style: texttheme.titleSmall?.
                    copyWith(color: Colors.grey),),
                  const SizedBox(height:20),
                  _buildresetPassForm(),  //return widgrt method signin form
                  const SizedBox(height:48),
                  Center(
                    child: Column(
                      children: [
                        _buildresetPassSection()// return widget method sign up button
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
  Widget _buildresetPassForm (){
    return    Form(
    key: _formkey,
      child: Column(
        children: [
          TextFormField(
            controller: _oldpasswordController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: "Password"
            ),
          validator: (String?value){
              if(value?.isEmpty==true){
                return "Enter a old value";
              }
              return null;
          },
          ),
          const SizedBox(height: 16,),
          TextFormField(
            controller: _newpasswordController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: "Confirm Password"
            ),
            validator: (String?value){
              if(value?.isEmpty==true){
                return "Enter a old value";
              }
              return null;
            },
          ),
          const SizedBox(height: 24,),
          ElevatedButton(
              onPressed:_onTapNextPage,
              child: const Icon(Icons.arrow_circle_right_outlined)),
        ],
      ),
    );
  }

  void _onTapNextPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassOtp()));
    // TODO:implementation on tap next page
  }

  // don't have an account er text
  Widget  _buildresetPassSection(){
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
