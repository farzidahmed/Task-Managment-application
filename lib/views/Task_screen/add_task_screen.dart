import 'package:flutter/material.dart';
import 'package:task_managment/global_widget/app_bar_style.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const AppBarStyle(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 42,),
                Text("Add New Task",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600
                  ),),
             const SizedBox(height: 24,),
                TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Add Task",
                        ),
                ),
                const SizedBox(height: 24,),
                TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Description",
                  ),
                ),
                const SizedBox(height: 24,),
                ElevatedButton(onPressed: _buildAddTask,
                    child: const Icon(Icons.arrow_forward_ios)),

              ],
            ),
          ),
        ),
      ),
    );
  }
  void _buildAddTask(){
    //TODO: implemnets go to newtaskscreen
    Navigator.pop(context);
  }
}
