import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sms_demo/Data/auth/data_provider/auth_provider.dart';
import 'package:sms_demo/Domain/model/auth/user.dart';
import 'package:sms_demo/Domain/model/auth/user_response.dart';

class AuthRemoteProvider extends AuthProvider {
  String baseUrl = "http://localhost:5000/api/auth";

  @override
  Future<UserResponse> authenticateUser(User user) async {
    final response = await http.post(Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "username": user.username,
          "password": user.password
        }));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body);
      final userResponse = UserResponse.fromJson(body);
      print(userResponse.role);
      return userResponse;
    }
    throw Exception('authentication failed');
  }
}
