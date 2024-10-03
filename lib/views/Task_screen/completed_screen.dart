import 'package:flutter/material.dart';
import 'package:task_managment/global_widget/app_bar_style.dart';

import '../../global_widget/task_list_card.dart';
import '../../global_widget/task_summerry_card.dart';
import 'add_task_screen.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _ComletedScreenState();
}

class _ComletedScreenState extends State<CompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Column(
        children: [
          // task list card
          task_list_card(buttonname: 'Completed', chipcolor: Colors.greenAccent,)
        ],
      ),

    );
  }
  }

