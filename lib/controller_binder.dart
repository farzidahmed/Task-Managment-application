import 'package:get/get.dart';
import 'package:task_managment/ui/controller/Completed_Task_Controller.dart';
import 'package:task_managment/ui/controller/SignIn_controller.dart';
import 'package:task_managment/ui/controller/new_task_list_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SignInController());
    Get.put(NewTaskListController());
    Get.put(CompletedTaskController());
  }

}