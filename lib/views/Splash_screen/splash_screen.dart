import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_managment/controller/auth_controller.dart';
import 'package:task_managment/global_widget/navbar_screen.dart';
import '../../global_widget/background_image.dart';
import '../../utills/assets_path.dart';
import '../Auth_screen/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    await AuthController.getAccessData();
    if(AuthController.isLoggedIn()){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const NavbarScreen()));
    }else{
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignInScreen()));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundImage(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsPath.logoSvg),
          ],
        ),
      ),
    ));
  }
}
