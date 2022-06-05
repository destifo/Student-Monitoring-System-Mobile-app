import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_demo/Bloc/auth/auth_event.dart';
import 'package:sms_demo/Bloc/auth/auth_state.dart';
import 'package:sms_demo/Data/auth/data_repository/auth_repository.dart';
import 'package:sms_demo/Domain/model/auth/user.dart';
import 'package:sms_demo/Domain/model/auth/user_response.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(Idle()) {
    on<Login>(_onLogin);
  }

  void _onLogin(Login event, Emitter emit) async {
    emit(LogingIn());
    String username = event.username;
    String password = event.password;

    User user = User(username: username, password: password);

    UserResponse response = await authRepository.getUserInfo(user);

    if (response.role == '-1') {
      emit(LoginFailed());
    } else {
      emit(LoginSuccessful(response: response));
    }
  }
}
