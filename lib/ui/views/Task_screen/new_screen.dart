import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_managment/ui/controller/new_task_list_controller.dart';
import '../../../data/api_controlls/models/network_responce.dart';
import '../../../data/api_controlls/models/taskStatusCount.dart';
import '../../../data/api_controlls/models/task_status_model.dart';
import '../../../data/api_controlls/services/network_caller.dart';
import '../../global_widget/snakbar_message.dart';
import '../../global_widget/task_list_card.dart';
import '../../global_widget/task_summerry_card.dart';
import '../../utills/urls.dart';
import 'add_task_screen.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  bool _getTaskCountInprogress = false;
  List<TaskStatusModel> _taskStatusCountlist = [];

  final NewTaskListController _newTaskListController = Get.find<NewTaskListController>();

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
              child: GetBuilder<NewTaskListController>(
                builder: (controller) {
                  return Visibility(
                    visible: !controller.inProgress,
                    replacement: const CircularProgressIndicator(),
                    child: ListView.separated(
                      itemCount: controller.newtasklist.length,
                      itemBuilder: (context, index) {
                        return task_list_card(
                          buttonname: 'New',
                          chipcolor: Colors.greenAccent,taskModel: controller.newtasklist[index], onrefress: _getNewTask,

                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 2);
                      },
                    ),
                  );
                }
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
      padding: const EdgeInsets.all(8.0),
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
   Get.to(const AddTaskScreen());
    if(shouldRefresh==true){
      _getNewTask();
    }
  }

  Future<void> _getNewTask() async {
    final bool result= await _newTaskListController.getNewTask();
    if (result ==false) {
      snakbarmessage(context, _newTaskListController.errorMesseage!,true);
    }
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
