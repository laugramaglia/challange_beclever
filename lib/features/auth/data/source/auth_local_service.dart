import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  Future<void> logout();

  // Handle token
  String? getToken();
  Future<bool> setToken(String token);
  Future<bool?> clearToken();
}

class AuthLocalServiceImpl extends AuthLocalService {
  //* In production app, i would use [flutter_secure_storage]
  final SharedPreferences sharedPreferences;

  AuthLocalServiceImpl({required this.sharedPreferences});

  @override
  String? getToken() => sharedPreferences.getString('token');

  @override
  Future<bool> setToken(String token) async {
    return await sharedPreferences.setString('token', token);
  }

  @override
  Future<bool?> clearToken() async {
    if (sharedPreferences.containsKey('token')) {
      return await sharedPreferences.remove('token');
    }
    return null;
  }

  @override
  Future<void> logout() async {
    sharedPreferences.clear();
  }
}
