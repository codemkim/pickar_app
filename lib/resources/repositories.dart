import 'dart:async';
import 'package:pickar_app/resources/auth_provider.dart';

class AuthRepository {
  final authProvider = AuthProvider();

  Future<String> doBaseLogin(dynamic data) => authProvider.doBaseLogin(data);

  Future<bool> doKakaoLogin(dynamic data) => authProvider.doKakaoLogin(data);

  Future<bool> doGoogleLogin(dynamic data) => authProvider.doGoogleLogin(data);

  Future<bool> logout() => authProvider.logout();

  // Future<bool> doRegister(dynamic data) => authProvider.doRegister(data);

}

