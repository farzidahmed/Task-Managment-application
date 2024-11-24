import 'package:get/get.dart';
import 'package:task_managment/data/api_controlls/models/network_responce.dart';
import 'package:task_managment/data/api_controlls/models/task_list_model.dart';
import 'package:task_managment/data/api_controlls/models/task_model.dart';
import 'package:task_managment/data/api_controlls/services/network_caller.dart';
import 'package:task_managment/ui/utills/urls.dart';

class NewTaskListController extends GetxController {
  bool _inprogress = false;
  String? _errorMesseage;

  String? get errorMesseage => _errorMesseage;

  bool get inProgress => _inprogress;
  List<TaskModel> _newtasklist = [];

  List<TaskModel> get newtasklist => _newtasklist;

  Future<bool> getNewTask() async {
    bool isSuccess = false;

    _newtasklist.clear();
    _inprogress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.newtasklist);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newtasklist = taskListModel.tasklist ?? [];
      isSuccess = true;
    } else {
      _errorMesseage = response.errormessege;
    }
    _inprogress = false;
    update();
    return isSuccess;
  }
}
