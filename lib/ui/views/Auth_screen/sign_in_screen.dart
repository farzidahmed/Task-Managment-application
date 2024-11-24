import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_managment/ui/controller/SignIn_controller.dart';
import '../../global_widget/background_image.dart';
import '../../global_widget/navbar_screen.dart';
import '../../global_widget/snakbar_message.dart';
import '../../utills/apps_colors.dart';
import 'forgot_password_email.dart';
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
  SignInController signInController= Get.find<SignInController>();

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
          GetBuilder<SignInController>(
            builder: (context) {
              return Visibility(
                visible: !context.inprogress,
                replacement: const CircularProgressIndicator(),
                child: ElevatedButton(
                    onPressed: _onTapNextPage,
                    child: const Icon(Icons.arrow_circle_right_outlined)),
              );
            }
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
    final bool result = await signInController
        .signin(_textEmailController.text.trim(), _textPasswordController);

    if (result) {
     Get.offAllNamed(NavbarScreen.name);
    } else {
      // jodi success nah hoy tahole
      snakbarmessage(context, signInController.errorMesseage!, true);
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
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
    Get.to(SignUpScreen());
  }
}
