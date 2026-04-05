class Failure {
  final String detail;
  final List<String>? errors;

  Failure({
    required this.detail,
    this.errors,
  });
}
