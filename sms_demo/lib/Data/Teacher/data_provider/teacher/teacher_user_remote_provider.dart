import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sms_demo/Data/Teacher/data_provider/teacher/teacher_user_provider.dart';
import 'package:sms_demo/Data/local/shared_preferences/shared_preference_service.dart';
import 'package:sms_demo/Domain/model/teacher/teacher.dart';

class TeacherUserRemoteProvider implements TeacherUserProvider {
  final _baseUrl = 'http://localhost:5000/api/teachers';

  final SharedPreferenceService prefService = SharedPreferenceService();

  // TeacherUserRemoteProvider({required this.id});
  @override
  Future<TeacherModel> getTeacher() async {
    var id = await prefService.getValueOf('id');
    var token = await prefService.getToken();
    print('$_baseUrl/$id');
    final response = await http
        .get(Uri.parse('$_baseUrl/$id'), headers: {'auth-token': token});
    print(response.statusCode);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print(decoded);
      return TeacherModel.fromJson(decoded);
    }
    throw Exception("Teacher Not Found");
  }
}
