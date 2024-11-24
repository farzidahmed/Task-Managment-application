import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_managment/ui/controller/Completed_Task_Controller.dart';
import '../../global_widget/snakbar_message.dart';
import '../../global_widget/task_list_card.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _ComletedScreenState();
}

class _ComletedScreenState extends State<CompletedScreen> {
  final CompletedTaskController _completedTaskController = Get.find<CompletedTaskController>();

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
              child: GetBuilder<CompletedTaskController>(
                builder: (controller) {
                  return Visibility(
                    visible: !controller.inProgress,
                    replacement: const CircularProgressIndicator(),
                    child: ListView.separated(
                      itemCount: controller.completedtasklist.length,
                      itemBuilder: (context, index) {
                        return task_list_card(
                          buttonname: 'Completed',
                          chipcolor: Colors.greenAccent,
                          taskModel: controller.completedtasklist[index], onrefress: _getCompletedTaskList,
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

    );
  }

  Future<void> _getCompletedTaskList() async {
    final bool result =await _completedTaskController.getCompletedTaskList();
    if (result) {
      snakbarmessage(context,_completedTaskController.errorMesseage!,true);
    }

  }

}

