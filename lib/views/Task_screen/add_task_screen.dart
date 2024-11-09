import 'package:flutter/material.dart';
import 'package:task_managment/api_controlls/models/network_responce.dart';
import 'package:task_managment/api_controlls/services/network_caller.dart';
import 'package:task_managment/controller/auth_controller.dart';
import 'package:task_managment/global_widget/app_bar_style.dart';
import 'package:task_managment/global_widget/snakbar_message.dart';
import 'package:task_managment/utills/urls.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _textTaskController = TextEditingController();
  final TextEditingController _textDescription = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _addnewtaskInprogress = false;

  bool _shouldRefreshReverse=false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didpop,result){
        if(didpop){
          return;
        }
        Navigator.pop(context,_shouldRefreshReverse);
      },
      child: Scaffold(
        appBar: const AppBarStyle(),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 42,
                  ),
                  Text(
                    "Add New Task",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  _buildTextField(),
                  const SizedBox(
                    height: 24,
                  ),
                  Visibility(
                    visible: !_addnewtaskInprogress,
                    replacement: const CircularProgressIndicator(),
                    child: ElevatedButton(
                        onPressed: _buildAddTask,
                        child: const Icon(Icons.arrow_forward_ios)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
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
              if (value?.isEmpty ?? true) {
                return 'Enter a text please';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: _textDescription,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Description",
            ),
            validator: (String? value) {
              if (value?.isEmpty?? true) {
                return 'Enter a description please';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  void _buildAddTask() {
    //TODO: implemnets go to newtaskscreen
    if (_form.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _addnewtaskInprogress = true;
    setState(() {});
    Map<String, dynamic> requestbody = {
      "title": _textTaskController.text.trim(),
      "description": _textDescription.text.trim(),
      "status": "New"
    };

    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.createtask,
        body: requestbody,
    );
    _addnewtaskInprogress = false;
    setState(() {});

    //then ckh korbo response success ki nah ...
    // jodi success hoy tahole navigator kore dibo
    if(response.isSuccess==true){
      _shouldRefreshReverse=true;
      _cleartextfiled();
      setState(() {});
      snakbarmessage(context, "Add a new task ");
    }else{
      // jodi success nah hoy tahole
      snakbarmessage(context,response.errormessege,true);
    }
}
  void _cleartextfiled(){
    _textTaskController.clear();
    _textDescription.clear();
    debugPrint("Text fields cleared: ${_textTaskController.text}, ${_textDescription.text}");
  }

}
