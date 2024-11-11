import 'package:flutter/material.dart';

import '../../api_controlls/models/network_responce.dart';
import '../../api_controlls/models/task_list_model.dart';
import '../../api_controlls/models/task_model.dart';
import '../../api_controlls/services/network_caller.dart';
import '../../global_widget/snakbar_message.dart';
import '../../global_widget/task_list_card.dart';
import '../../utills/urls.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ComletedScreenState();
}

class _ComletedScreenState extends State<ProgressScreen> {
  bool _getProgressTaskInprogress = false;
  List<TaskModel> _progresstasklist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProgressTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  RefreshIndicator(
        onRefresh: ()async{
          _getProgressTaskList();
        },
        child: Column(
          children: [
            // task list card
            Expanded(
              child: Visibility(
                visible: !_getProgressTaskInprogress,
                replacement: const CircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _progresstasklist.length,
                  itemBuilder: (context, index) {
                    return task_list_card(
                      buttonname: 'Progress',
                      chipcolor: Colors.purpleAccent,
                      taskModel: _progresstasklist[index], onrefress: _getProgressTaskList,
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

  Future<void> _getProgressTaskList() async {
    _progresstasklist.clear();
    _getProgressTaskInprogress = true;
    setState(() {});

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.progresstasklist);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      _progresstasklist = taskListModel.tasklist ?? [];
    } else {
      snakbarmessage(context, response.errormessege);
    }
    _getProgressTaskInprogress = false;
    setState(() {});
  }

}

