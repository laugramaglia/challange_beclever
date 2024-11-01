class Response {
  final dynamic data;
  final int statusCode;
  Response({required this.data, required this.statusCode});

  @override
  String toString() {
    return 'Response{data: $data, statusCode: $statusCode}';
  }
}

class DioClientFake {
  DioClientFake();

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await Future.delayed(
        const Duration(seconds: 1),
        () => switch (url) {
              '/user' => Response(
                  data: {"name": "John Doe"},
                  statusCode: 200,
                ),
              _ => Response(
                  data: {"code": 500, "message": "Internal server error"},
                  statusCode: 500,
                )
            });
    return response;
  }

  // POST METHOD
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await Future<Response>.delayed(
        const Duration(seconds: 1),
        () => switch (url) {
              '/validate-phone' => _validatePhone(data),
              _ => Response(
                  data: {"code": 500, "message": "Internal server error"},
                  statusCode: 500,
                )
            });

    return response;
  }
}

Response _validatePhone(Map<String, dynamic> params) {
  // Check if code is even (divisible by 2 with no remainder)
  // and greater than 3000
  if (params['code'] % 2 == 0 && params['code'] > 3000) {
    // create user just with the phone number
    return Response(
      data: {"message": "Success"},
      statusCode: 201,
    );
  }
  return Response(
    data: {"message": "Telefono no valido"},
    statusCode: 500,
  );
}
