class ValidatePhoneReqParams {
  final String phoneNumber;
  final String code;

  ValidatePhoneReqParams({required this.phoneNumber, required this.code});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneNumber': int.tryParse(phoneNumber),
      'code': int.tryParse(code),
    };
  }
}
