import 'package:dartz/dartz.dart';

abstract class AuthLocalService {
  Future<bool> isLoggedIn();
  Future<Either> logout();
}

class AuthLocalServiceImpl extends AuthLocalService {
  @override
  Future<bool> isLoggedIn() async {
    return Future.value(true);
  }

  @override
  Future<Either> logout() async {
    return const Right(true);
  }
}
