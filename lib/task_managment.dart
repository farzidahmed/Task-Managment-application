import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_managment/ui/global_widget/navbar_screen.dart';
import 'package:task_managment/ui/utills/apps_colors.dart';
import 'package:task_managment/ui/views/Splash_screen/splash_screen.dart';


import 'controller_binder.dart';

class TaskManagment extends StatefulWidget {
  const TaskManagment({super.key});

  static GlobalKey<NavigatorState>navigatorkey=GlobalKey<NavigatorState>();
  @override
  State<TaskManagment> createState() => _TaskManagmentState();
}

class _TaskManagmentState extends State<TaskManagment> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagment.navigatorkey,
      theme: ThemeData(
        colorSchemeSeed: Appscolor.themecolor,
        textTheme: const TextTheme(),
        inputDecorationTheme:_inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData()
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      initialRoute: '/',
      routes: {
        SplashScreen.name:(context)=> const SplashScreen(),
        NavbarScreen.name:(context)=> const NavbarScreen(),

      },
    );

  }
  ElevatedButtonThemeData _elevatedButtonThemeData(){
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Appscolor.themecolor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
            fixedSize: const Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            )
        )
    );
  }
  InputDecorationTheme _inputDecorationTheme(){
    return  InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w300
        ),
        border:_inputBorder(),
      enabledBorder: _inputBorder(),
      focusedBorder: _inputBorder(),
      errorBorder: _inputBorder(),
    );
  }
  OutlineInputBorder _inputBorder(){
    return  OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8)
    );
  }
}
