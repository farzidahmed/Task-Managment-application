import 'package:flutter/material.dart';
import 'package:task_managment/global_widget/app_bar_style.dart';

import '../../global_widget/task_list_card.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({super.key});

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends State<CanceledScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          // task list card
          task_list_card(buttonname: 'Canceled', chipcolor: Colors.redAccent,bordersidecolor: Colors.white,)
        ],
      ),

    );

  }
}
