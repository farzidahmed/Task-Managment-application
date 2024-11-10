class Urls {
  //post api
  static const String _baseurl = 'http://35.73.30.144:2005/api/v1';
  static const String registration = '$_baseurl/Registration';
  static const String login = '$_baseurl/Login';
  static const String createtask = '$_baseurl/createTask';

  //get api
  static const String recoververifymail = '$_baseurl/RecoverVerifyEmail';
  static const String newtasklist = '$_baseurl/listTaskByStatus/New';
  static const String completedtasklist =
      '$_baseurl/listTaskByStatus/Completed';

  static String changeStatus(String taskId, String status) =>
      '$_baseurl/updateTaskStatus/$taskId/$status';
}
