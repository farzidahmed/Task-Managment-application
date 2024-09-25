import 'package:flutter/material.dart';
import 'package:task_managment/global_widget/background_image.dart';

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
      body: BackgroundImage(
          child: Padding(
             padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text("Get Started With",style: texttheme.displaySmall?.
                  copyWith(fontWeight: FontWeight.w500),),
                ),
                TextFormField(),
                TextFormField(),
              ],
            ),
          ) ),
    );
  }
}
