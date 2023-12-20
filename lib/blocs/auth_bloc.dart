import 'package:pickar_app/resources/repositories.dart';

class AuthBloc {
  final _authRepository = AuthRepository();

  Future<String> doBaseLogin(dynamic data) async {
    return await _authRepository.doBaseLogin(data);
  } 

  Future<String> doRegister(dynamic data) async {
    return await _authRepository.doRegister(data);
  }

  Future<bool> doKakaoLogin(dynamic data) async {
    return await _authRepository.doKakaoLogin(data);
  }

  Future<bool> doGoogleLogin(dynamic data) async {
    return await _authRepository.doGoogleLogin(data);
  }

  Future<bool> logout() async {
    return await _authRepository.logout();
  }
  

  dispose() {}
}

final authBloc = AuthBloc();