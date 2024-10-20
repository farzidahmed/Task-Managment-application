import 'package:flutter/material.dart';
import 'package:task_managment/global_widget/app_bar_style.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _textTaskController= TextEditingController();
  final TextEditingController _textDescription= TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

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
                _buildTextField(),
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

  Widget _buildTextField(){
   return Form(
     key: _form,
     child: Column(
       children: [
         TextFormField(
           controller: _textTaskController,
            decoration: const InputDecoration(
              hintText: "Add Task",
            ),
           validator: (String? value) {
             if (value?.isEmpty == true) {
               return 'Enter a text please';
             }
             return null;
           },
          ),
        const SizedBox(height: 24,),
         TextFormField(
           controller: _textDescription,
           maxLines: 5,
           decoration: const InputDecoration(
             hintText: "Description",
           ),
           validator: (String? value) {
             if (value?.isEmpty == true) {
               return 'Enter a description please';
             }
             return null;
           },
         ),
       ],
     ),
   );
  }

  void _buildAddTask(){
    //TODO: implemnets go to newtaskscreen
    if (!_form.currentState!.validate()) {
      return;
    }
    Navigator.pop(context);
  }

}
