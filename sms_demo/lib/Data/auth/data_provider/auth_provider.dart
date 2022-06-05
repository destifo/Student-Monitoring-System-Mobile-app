import 'package:sms_demo/Domain/model/auth/user.dart';
import 'package:sms_demo/Domain/model/auth/user_response.dart';

abstract class AuthProvider {
  Future<UserResponse> authenticateUser(User user);
}
