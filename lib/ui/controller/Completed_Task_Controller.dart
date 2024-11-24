import 'package:get/get.dart';
import 'package:task_managment/data/api_controlls/models/network_responce.dart';
import 'package:task_managment/data/api_controlls/models/task_list_model.dart';
import 'package:task_managment/data/api_controlls/models/task_model.dart';
import 'package:task_managment/data/api_controlls/services/network_caller.dart';
import 'package:task_managment/ui/utills/urls.dart';

class CompletedTaskController extends GetxController{
  bool _inprogress = false;
  String? _errorMesseage;

  String? get errorMesseage => _errorMesseage;

  bool get inProgress => _inprogress;
  List<TaskModel> _completedtasklist = [];
  List<TaskModel> get completedtasklist => _completedtasklist;

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;
    _completedtasklist.clear();
    _inprogress = true;
update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.completedtasklist);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      _completedtasklist = taskListModel.tasklist ?? [];
    } else {
     _errorMesseage=response.errormessege;
    }
    _inprogress = false;
update();
  return isSuccess;
  }

}