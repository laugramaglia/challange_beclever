import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  Future<void> logout();

  Future<bool> setToken(String token);
}

class AuthLocalServiceImpl extends AuthLocalService {
  final SharedPreferences sharedPreferences;

  AuthLocalServiceImpl({required this.sharedPreferences});

  @override
  Future<bool> setToken(String token) async {
    return await sharedPreferences.setString('token', token);
  }

  @override
  Future<void> logout() async {
    sharedPreferences.clear();
  }
}
