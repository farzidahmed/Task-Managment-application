import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_managment/api_controlls/models/network_responce.dart';
import 'package:task_managment/api_controlls/models/task_list_model.dart';
import 'package:task_managment/api_controlls/models/task_model.dart';
import 'package:task_managment/api_controlls/services/network_caller.dart';
import 'package:task_managment/global_widget/snakbar_message.dart';
import 'package:task_managment/utills/urls.dart';
import 'package:task_managment/views/Task_screen/add_task_screen.dart';
import '../../global_widget/task_list_card.dart';
import '../../global_widget/task_summerry_card.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  bool _getNewTaskInprogress = false;
  List<TaskModel> _newtasklist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
          _getNewTaskList();
        },
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    task_sumerry_card(
                      count: 5,
                      titile: "New",
                    ),
                    task_sumerry_card(
                      count: 10,
                      titile: "Completed",
                    ),
                    task_sumerry_card(
                      count: 10,
                      titile: "Canceled",
                    ),
                    task_sumerry_card(
                      count: 10,
                      titile: "Progress",
                    )
                  ],
                ),
              ),
            ),
            // task list card
            Expanded(
              child: Visibility(
                visible: !_getNewTaskInprogress,
                replacement: const CircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _newtasklist.length,
                  itemBuilder: (context, index) {
                    return task_list_card(
                      buttonname: 'New',
                      chipcolor: Colors.greenAccent,taskModel: _newtasklist[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 2);
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _buildAddScreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  //floatactionbutton
  Future<void> _buildAddScreen()async {
    final bool? shouldRefresh =await
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddTaskScreen()));
    if(shouldRefresh==true){
      _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async {
    _newtasklist.clear();
    _getNewTaskInprogress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.newtasklist);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newtasklist = taskListModel.tasklist ?? [];
    } else {
      snakbarmessage(context, response.errormessege);
    }
    _getNewTaskInprogress = false;
    setState(() {});
  }
}
