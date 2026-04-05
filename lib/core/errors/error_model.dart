class ErrorModel {
  final String msg;
  final String? status;
  final int? code;

  ErrorModel({
    required this.msg,
    this.status,
    this.code,
  });
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      msg: jsonData["msg"] ?? '',
      status: jsonData["status"] ?? '',
      code: jsonData["code"] ?? '',
    );
  }
}
