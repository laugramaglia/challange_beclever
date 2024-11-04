class CreatePassReqParams {
  final String password;
  final bool useBiometric;

  CreatePassReqParams({required this.password, required this.useBiometric});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
    };
  }
}
