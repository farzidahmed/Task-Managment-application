import 'package:flutter/material.dart';
import 'package:task_managment/global_widget/app_bar_style.dart';
import 'package:task_managment/views/Task_screen/canceled_screen.dart';
import 'package:task_managment/views/Task_screen/completed_screen.dart';
import 'package:task_managment/views/Task_screen/new_screen.dart';
import 'package:task_managment/views/Task_screen/progress_screen.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _seletedindex=0;
  //list of screen ....screnn gula serially dekhanor jonno

  final List<Widget> screens = const  [
    NewScreen(),
    CompletedScreen(),
    CanceledScreen(),
    ProgressScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle(),
      body: screens[_seletedindex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _seletedindex,
          onDestinationSelected: (int index){
          _seletedindex = index;
          // setstate bebohar koron hoilo ui te poriborton korar jonno
          setState(() {
          });
          },
          destinations:const [
            NavigationDestination(
                icon: Icon(Icons.library_books_sharp),
                label:"New"),
            NavigationDestination(
                icon: Icon(Icons.check_box_rounded),
                label:"Completed"),
            NavigationDestination(
                icon: Icon(Icons.close_rounded),
                label:"Canceled"),
            NavigationDestination(
                icon: Icon(Icons.refresh_outlined),
                label:"progress"),
          ] ),

    );

  }
}
