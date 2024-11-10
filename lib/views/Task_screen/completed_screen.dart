import 'package:flutter/material.dart';

import '../../api_controlls/models/network_responce.dart';
import '../../api_controlls/models/task_list_model.dart';
import '../../api_controlls/models/task_model.dart';
import '../../api_controlls/services/network_caller.dart';
import '../../global_widget/snakbar_message.dart';
import '../../global_widget/task_list_card.dart';
import '../../utills/urls.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _ComletedScreenState();
}

class _ComletedScreenState extends State<CompletedScreen> {
  bool _getCompletedTaskInprogress = false;
  List<TaskModel> _completedtasklist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompletedTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  RefreshIndicator(
        onRefresh: ()async{
          _getCompletedTaskList();
        },
        child: Column(
          children: [
            // task list card
            Expanded(
              child: Visibility(
                visible: !_getCompletedTaskInprogress,
                replacement: const CircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _completedtasklist.length,
                  itemBuilder: (context, index) {
                    return task_list_card(
                      buttonname: 'Completed',
                      chipcolor: Colors.greenAccent,
                      taskModel: _completedtasklist[index], onrefress: _getCompletedTaskList,
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

    );
  }

  Future<void> _getCompletedTaskList() async {
    _completedtasklist.clear();
    _getCompletedTaskInprogress = true;
    setState(() {});

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.completedtasklist);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      _completedtasklist = taskListModel.tasklist ?? [];
    } else {
      snakbarmessage(context, response.errormessege);
    }
    _getCompletedTaskInprogress = false;
    setState(() {});
  }

}

