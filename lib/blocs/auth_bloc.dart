

import 'package:pickar_app/resources/repositories.dart';

class AuthBloc {
  final _repository = AuthRepository();

  // Future<bool> doBaseLogin(dynamic data) async {
  //   return await _repository.doBaseLogin(data);
  // }
  

  Future<bool> doKakaoLogin(dynamic data) async {
    return await _repository.doKakaoLogin(data);
  }

  Future<bool> doGoogleLogin(dynamic data) async {
    return await _repository.doGoogleLogin(data);
  }

  Future<bool> logout() async {
    return await _repository.logout();
  }
  // Future<bool> doRegister(dynamic data) async {
  //   return await _repository.doRegister(data);
  // }

  dispose() {}
}

final authBloc = AuthBloc();