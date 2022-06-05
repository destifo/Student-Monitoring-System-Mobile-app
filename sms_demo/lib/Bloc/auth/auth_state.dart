import 'package:sms_demo/Domain/model/auth/user_response.dart';

abstract class AuthState {}

class Idle extends AuthState {}

class LogingIn extends AuthState {}

class LoginFailed extends AuthState {}

class LoginSuccessful extends AuthState {
  final UserResponse response;
  LoginSuccessful({
    required this.response,
  });
}
