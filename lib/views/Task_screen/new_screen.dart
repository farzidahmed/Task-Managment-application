import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_managment/views/Task_screen/add_task_screen.dart';

import '../../global_widget/task_summerry_card.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  task_sumerry_card(count: 10,titile: "New",),
                  task_sumerry_card(count: 10,titile: "Completed",),
                  task_sumerry_card(count: 10,titile: "Canceled",),
                  task_sumerry_card(count: 10,titile: "Progress",)
                ],
              ),
            ),
          )
        ],
      ),
        floatingActionButton: FloatingActionButton(onPressed: _buildAddScreen,
        child: const Icon(Icons.add),
        ),
    );
  }
  //floatactionbutton
  void _buildAddScreen(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddTaskScreen()));
  }
}

