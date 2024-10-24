import 'package:flutter/material.dart';
import 'package:task_managment/views/Splash_screen/splash_screen.dart';

import 'utills/apps_colors.dart';

class TaskManagment extends StatefulWidget {
  const TaskManagment({super.key});

  static GlobalKey<NavigatorState>navigatorkey=GlobalKey<NavigatorState>();
  @override
  State<TaskManagment> createState() => _TaskManagmentState();
}

class _TaskManagmentState extends State<TaskManagment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagment.navigatorkey,
      theme: ThemeData(
        colorSchemeSeed: Appscolor.themecolor,
        textTheme: const TextTheme(),
        inputDecorationTheme:_inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData()
      ),
      home:const SplashScreen(),
      debugShowCheckedModeBanner: false,
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
