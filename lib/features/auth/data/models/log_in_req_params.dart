class LogInReqParams {
  final String cedula;
  final String password;

  LogInReqParams({required this.password, required this.cedula});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cedula': cedula,
      'password': password,
    };
  }
}
