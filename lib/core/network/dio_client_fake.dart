import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

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
  const DioClientFake();

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await Future.delayed(
        const Duration(seconds: 1),
        () => switch (url) {
              '/user' => _getUser(queryParameters),
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
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await Future<Response>.delayed(
        const Duration(seconds: 1),
        () => switch (url) {
              '/login' => _login(data),
              '/validate-phone' => _validatePhone(data),
              _ => Response(
                  data: {"code": 500, "message": "Internal server error"},
                  statusCode: 500,
                )
            });

    return response;
  }

  // PATCH METHOD
  Future<Response> patch(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response =
        await Future.delayed(const Duration(seconds: 1), () async {
      return switch (url) {
        '/create-password' => await _createPass(data?['password']),
        _ => Response(
            data: {"code": 500, "message": "Internal server error"},
            statusCode: 500,
          )
      };
    });
    return response;
  }
}

Future<Response> _getUser(Map<String, dynamic>? params) async {
  // Get user from shared preferences, to simulate external db
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final user = prefs.getString('user');
  if (user == null) {
    return Response(
      data: {'message': 'User not found'},
      statusCode: 404,
    );
  }
  return Response(
    data: {'message': 'Success', 'user': jsonDecode(user)},
    statusCode: 200,
  );
}

Future<Response> _createPass(String? password) async {
  // Get user from shared preferences, to simulate external db
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final user = prefs.getString('user');
  if (user == null) {
    return Response(
      data: {"message": "Usuario no encontrado"},
      statusCode: 404,
    );
  }

  Map<String, dynamic> userJson = jsonDecode(user);

  if (userJson['password'] != null) {
    return Response(
      data: {"message": "Contraseña ya creada"},
      statusCode: 401,
    );
  }

  userJson.addAll({'password': password});
  prefs.setString('user', jsonEncode(userJson));

  return Response(
    data: {"message": "Success"},
    statusCode: 201,
  );
}

Future<Response> _validatePhone(Map<String, dynamic>? params) async {
  if (params == null) {
    return Response(
      data: {"message": "Telefono no valido"},
      statusCode: 500,
    );
  }
  // Check if code is even (divisible by 2 with no remainder)
  // and greater than 3000
  if (params['code'] % 2 == 0 && params['code'] > 3000) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // create user just with the phone number

    final user = {'id': '1', ...params};

    prefs.setString('user', jsonEncode(user));
    return Response(
      data: {"message": "Success", 'token': 'bearer-token', 'value': user},
      statusCode: 201,
    );
  }
  return Response(
    data: {"message": "Telefono no valido"},
    statusCode: 500,
  );
}

Future<Response> _login(Map<String, dynamic>? params) async {
  if (params == null) {
    return Response(
      data: {"message": "Credenciales no validas"},
      statusCode: 500,
    );
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final user = prefs.getString('user');
  final cCedula = params['cedula'];
  final cPassword = params['password'];

  if (user == null) {
    return Response(
      data: {"message": "User not found"},
      statusCode: 404,
    );
  }
  final userJson = jsonDecode(user);

  if (userJson['cedula'] != cCedula || userJson['password'] != cPassword) {
    return Response(
      data: {"message": "Credenciales no validas"},
      statusCode: 401,
    );
  }
  return Response(
    data: {"message": "Success", 'token': 'bearer-token', 'value': userJson},
    statusCode: 201,
  );
}
