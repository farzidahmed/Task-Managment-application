import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_managment/api_controlls/models/network_responce.dart';
import 'package:task_managment/api_controlls/models/taskStatusCount.dart';
import 'package:task_managment/api_controlls/models/task_list_model.dart';
import 'package:task_managment/api_controlls/models/task_model.dart';
import 'package:task_managment/api_controlls/models/task_status_model.dart';
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
  bool _getTaskCountInprogress = false;
  List<TaskModel> _newtasklist = [];
  List<TaskStatusModel> _taskStatusCountlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
          _getNewTask();
          _getTaskCount();
        },
        child: Column(
          children: [
            _buildsummerysetion(),
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
                      chipcolor: Colors.greenAccent,taskModel: _newtasklist[index], onrefress: _getNewTask,

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
  Widget _buildsummerysetion(){
   return Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
            _getTaskSummeryCardList()
        ),
      ),
    );
  }
  List<Tasksummerycard> _getTaskSummeryCardList(){
    List<Tasksummerycard> taskSummeryCard=[];
    for(TaskStatusModel t in _taskStatusCountlist ){
      taskSummeryCard.add(Tasksummerycard(titile: t.sId!, count: t.sum!));
    }
    return taskSummeryCard;
  }
  //floatactionbutton
  Future<void> _buildAddScreen()async {
    final bool? shouldRefresh =await
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddTaskScreen()));
    if(shouldRefresh==true){
      _getNewTask();
    }
  }

  Future<void> _getNewTask() async {
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

  Future<void> _getTaskCount() async {
    _taskStatusCountlist.clear();
    _getTaskCountInprogress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskstatuscount);

    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
          TaskStatusCountModel.fromJson(response.responseData);
      _taskStatusCountlist = taskStatusCountModel.taskStatusCountList ?? [];
    } else {
      snakbarmessage(context, response.errormessege);
    }
    _getTaskCountInprogress = false;
    setState(() {});
  }
}
