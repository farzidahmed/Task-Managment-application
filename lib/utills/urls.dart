class Urls {
  //post api
  static const String _baseurl = 'http://35.73.30.144:2005/api/v1';
  static const String registration = '$_baseurl/Registration';
  static const String login = '$_baseurl/Login';
  static const String createtask = '$_baseurl/createTask';

  //get api
  static const String recoververifymail = '$_baseurl/RecoverVerifyEmail';
  static const String newtasklist = '$_baseurl/listTaskByStatus/New';
  static const String completedtasklist = '$_baseurl/listTaskByStatus/Completed';
  static const String canceledtasklist = '$_baseurl/listTaskByStatus/Canceled';
  static const String progresstasklist = '$_baseurl/listTaskByStatus/Progress';
  static const String taskstatuscount = '$_baseurl/taskStatusCount';

  static String changeStatus(String taskId, String status) =>
      '$_baseurl/updateTaskStatus/$taskId/$status';

  static String deleteTask(String taskId) =>
      '$_baseurl/deleteTask/$taskId';
}
