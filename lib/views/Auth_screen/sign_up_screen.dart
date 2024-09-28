import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment/global_widget/background_image.dart';
import 'package:task_managment/utills/apps_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme texttheme = Theme.of(context).textTheme;
    return  Scaffold(
      resizeToAvoidBottomInset: false,
        body: BackgroundImage(child:
        Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10.0,
                right: 10.0,
                top: 10.0,
                bottom: 10.0+MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Join With Us",style: texttheme.displaySmall?.
                  copyWith(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 16,),
                  _buildSigninForm(),  //return widgrt method signin form
                  const SizedBox(height:30),
                  Center(
                    child: Column(
                      children: [
                        _buildSigninSection()// return widget method sign up button
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
          decoration: const InputDecoration(
              hintText: "First Name"
          ),
        ),
        SizedBox(height: 16,),
        TextFormField(
          decoration: const InputDecoration(
              hintText: "Last Name"
          ),
        ),
        const SizedBox(height: 16,),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
              hintText: "Mobile"
          ),
        ),
        const SizedBox(height: 16,),
        TextFormField(
          decoration: const InputDecoration(
              hintText: "password"
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

  // don't have an account er text
  Widget  _buildSigninSection(){
    return  RichText(text:  TextSpan(
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 0.5
        ),
        text: "Have an Account ?",
        children: [
          TextSpan(
              text: "Sign In ",
              style: TextStyle(color: Appscolor.themecolor),
              recognizer: TapGestureRecognizer()
                ..onTap = _onTapSignIn
          )
        ]
    ));
  }

  // click signup page button and goto next page
  void _onTapSignIn(){
        Navigator.pop(context);
  }


}
