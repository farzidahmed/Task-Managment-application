class NetworkResponse {
  final bool isSuccess;
  final int? statusCode;
  dynamic responseData;
  String errormessege;

  NetworkResponse(
      {  required this.isSuccess,
       this.statusCode,
       this.responseData,
      this.errormessege = "Something went wrong"});
}
