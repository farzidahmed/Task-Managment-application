import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_managment/api_controlls/models/network_responce.dart';
import 'package:task_managment/api_controlls/services/network_caller.dart';
import 'package:task_managment/global_widget/background_image.dart';
import 'package:task_managment/global_widget/circularProgressIndicator.dart';
import 'package:task_managment/global_widget/snakbar_message.dart';
import 'package:task_managment/utills/apps_colors.dart';
import 'package:task_managment/utills/urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final GlobalKey<FormState> _formkey= GlobalKey<FormState>();

final TextEditingController _emailTeController= TextEditingController();
final TextEditingController _firstNameTeController= TextEditingController();
final TextEditingController _lastNameTeController= TextEditingController();
final TextEditingController _mobileTeController= TextEditingController();
final TextEditingController _passwordTeController= TextEditingController();
 bool _inprogress=false;

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

  
  //api caller method

  Future<void> _signup() async {
    _inprogress = true;
    setState(() {});
      Map<String,dynamic>requestbody={
        "email":_emailTeController.text.trim(),
        "firstName":_firstNameTeController.text.trim(),
        "lastName":_lastNameTeController.text.trim(),
        "mobile":_mobileTeController.text.trim(),
        "password":_passwordTeController.text
    };
    // Network response er jonno call
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registration,
    body: requestbody);

    _inprogress = false;
    setState(() {});
    if (response.isSuccess== true) {
      _clearText();
      setState(() {});
    snakbarmessage(context,"New user created");
    } else {
      // Error message show kora
      snakbarmessage(context, response.errormessege,true);
    }

  }
  void _clearText(){
   _emailTeController.clear();
   _firstNameTeController.clear();
   _lastNameTeController.clear();
   _mobileTeController.clear();
   _passwordTeController.clear();
  }



// textformfiled er text
  Widget _buildSigninForm (){
    return    Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction ,
            controller: _emailTeController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: "Email",
            ),
            // form validation
            validator: (String?  value){
              if(value?.isEmpty??true){
                return "Enter your Email";
              }else if(!value!.contains("@")){
               return "Enter your valid value";
              }

              return null;
            },
          ),
          const SizedBox(height: 16,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction ,
            controller: _firstNameTeController,
            decoration: const InputDecoration(
                hintText: "First Name"
            ),
            validator: (String?  value){
              if(value?.isEmpty??true){
                return "Enter your First Name";
              }
              return null;

            },
          ),
          const SizedBox(height: 16,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction ,
            controller: _lastNameTeController,
            decoration: const InputDecoration(
                hintText: "Last Name"
            ),
            validator: (String?  value){
              if(value?.isEmpty??true){
                return "Enter your Last Name";
              }
              return null;

            },
          ),
          const SizedBox(height: 16,),
          TextFormField(
            maxLength: 11,
            autovalidateMode: AutovalidateMode.onUserInteraction ,
            controller: _mobileTeController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
                hintText: "Mobile",
            ),
            validator: (String?  value){
              if(value?.isEmpty??true){
                return "Enter your Mobile Number";
              }
              return null;

            },
          ),
          const SizedBox(height: 16,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction ,
            controller: _passwordTeController,
            decoration: const InputDecoration(
                hintText: "password"
            ),

            validator: (String?  value){
              if(value?.isEmpty??true){
                return "Enter your Password";
              }
              return null;

            },
          ),
        const        SizedBox(height: 16,),
          //visibility visible korte pare akta widget ke
          Visibility(
            visible: !_inprogress,
            replacement: Circularprogressindicator(),
            child: ElevatedButton(
                onPressed:_onTapNextPage,
                child: const Icon(Icons.arrow_circle_right_outlined)),
          ),
        ],
      ),
    );
  }

  void _onTapNextPage(){
    // TODO:implementation on tap next page

    if(_formkey.currentState!.validate()){
      //api call method
      _signup();
    }
  }



  // don't have an account er text
  Widget  _buildSigninSection(){
    return  RichText(text:  TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 0.5
        ),
        text: "Have an Account ?",
        children: [
          TextSpan(
              text: "Sign In ",
              style: const TextStyle(color: Appscolor.themecolor),
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


  @override
  void dispose() {
    _emailTeController.dispose();
    _firstNameTeController.dispose();
    _lastNameTeController.dispose();
    _mobileTeController.dispose();
    _passwordTeController.dispose();
    super.dispose();
  }

}
