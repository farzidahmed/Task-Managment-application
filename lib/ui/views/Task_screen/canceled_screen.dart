import 'package:flutter/material.dart';
import '../../../data/api_controlls/models/network_responce.dart';
import '../../../data/api_controlls/models/task_list_model.dart';
import '../../../data/api_controlls/models/task_model.dart';
import '../../../data/api_controlls/services/network_caller.dart';
import '../../global_widget/snakbar_message.dart';
import '../../global_widget/task_list_card.dart';
import '../../utills/urls.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({super.key});

  @override
  State<CanceledScreen> createState() => _ComletedScreenState();
}

class _ComletedScreenState extends State<CanceledScreen> {
  bool _getCanceledTaskInprogress = false;
  List<TaskModel> _canceledtasklist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCancledTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  RefreshIndicator(
        onRefresh: ()async{
          _getCancledTaskList();
        },
        child: Column(
          children: [
            // task list card
            Expanded(
              child: Visibility(
                visible: !_getCanceledTaskInprogress,
                replacement: const CircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _canceledtasklist.length,
                  itemBuilder: (context, index) {
                    return task_list_card(
                      buttonname: 'Canceled',
                      chipcolor: Colors.greenAccent,
                      taskModel: _canceledtasklist[index], onrefress: _getCancledTaskList,
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

  Future<void> _getCancledTaskList() async {
    _canceledtasklist.clear();
    _getCanceledTaskInprogress = true;
    setState(() {});

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.progresstasklist);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      _canceledtasklist = taskListModel.tasklist ?? [];
    } else {
      snakbarmessage(context, response.errormessege);
    }
    _getCanceledTaskInprogress = false;
    setState(() {});
  }

}

