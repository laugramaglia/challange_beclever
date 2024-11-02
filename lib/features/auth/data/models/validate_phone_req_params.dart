class ValidatePhoneReqParams {
  final String cedula;
  final String phoneNumber;
  final String code;

  ValidatePhoneReqParams(
      {required this.phoneNumber, required this.code, required this.cedula});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cedula': cedula,
      'phoneNumber': phoneNumber,
      'code': int.tryParse(code),
    };
  }
}
