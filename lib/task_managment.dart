import 'package:flutter/material.dart';
import 'package:task_managment/views/splash_screen.dart';

class TaskManagment extends StatefulWidget {
  const TaskManagment({super.key});

  @override
  State<TaskManagment> createState() => _TaskManagmentState();
}

class _TaskManagmentState extends State<TaskManagment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme()
      ),
      home:SplashScreen(),
      debugShowCheckedModeBanner: false,
    );

  }
}
