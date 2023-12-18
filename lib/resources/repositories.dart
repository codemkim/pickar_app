import 'dart:async';
import 'package:pickar_app/resources/auth_provider.dart';

class AuthRepository {
  final authProvider = AuthProvider();

  Future<String> doBaseLogin(dynamic data) => authProvider.doBaseLogin(data);

  Future<String> doRegister(dynamic data) => authProvider.doRegister(data);

  Future<bool> doKakaoLogin(dynamic data) => authProvider.doKakaoLogin(data);

  Future<bool> doGoogleLogin(dynamic data) => authProvider.doGoogleLogin(data);

  Future<bool> logout() => authProvider.logout();

  

}

