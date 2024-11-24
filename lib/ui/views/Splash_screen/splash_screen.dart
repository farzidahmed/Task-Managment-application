import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../controller/auth_controller.dart';
import '../../global_widget/background_image.dart';
import '../../global_widget/navbar_screen.dart';
import '../../utills/assets_path.dart';
import '../Auth_screen/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String name = '/';
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
      await AuthController.getUserData();
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
