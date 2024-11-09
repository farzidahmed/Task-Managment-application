import 'package:flutter/material.dart';
import 'package:task_managment/global_widget/app_bar_style.dart';

import '../../global_widget/task_list_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Column(
        children: [
          // task list card
          task_list_card(buttonname: 'progress', chipcolor: Colors.purpleAccent,bordersidecolor: Colors.black,)
        ],
      ),

    );

  }
}
