import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sms_demo/Data/admin/Management/data_provider/teacher_provider/teacher_provider.dart';
import 'package:sms_demo/Data/local/shared_preferences/shared_preference_service.dart';
import 'package:sms_demo/Domain/model/admin/Management/teacher_model.dart';

class TeacherApiProvider implements TeacherProvider {
  String baseUrl = "http://localhost:5000/api/users";
  String baseUrl2 = "http://localhost:5000/api/teachers";
  final SharedPreferenceService prefService = SharedPreferenceService();
  // String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjliMjQ5MWI1NTFmNjQ0MDg0MmY2MjIiLCJpYXQiOjE2NTQzMzQ3MzZ9.5nK5sxc-49X5u_l7rlP1rNJPWpDSs07QzwWuUWpgP8Y";
  @override
  Future addTeacher(TeacherModel teacher) async {
    var token = await prefService.getToken();
    TeacherModel teacher2 = TeacherModel(
      username: teacher.username,
      sections: teacher.sections,
      subjectName: teacher.subjectName,
      gender: teacher.gender,
      name: teacher.name,
      password: teacher.password,
    );
    print("${teacher.gender} ${teacher.username}");
    final response = await http.post(Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': token
        },
        body: jsonEncode(<String, String>{
          'username': teacher2.username,
          'password': teacher2.password!,
          'role': 'teacher',
        }));
    final response2 = await http.post(
      Uri.parse(baseUrl2),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': token
      },
      body: jsonEncode(<String, dynamic>{
        'sections': teacher2.sections,
        "subjectName": teacher2.subjectName,
        'name': teacher2.name,
        'username': teacher2.username,
        'gender': teacher2.gender,
      }),
    );
    if (response2.statusCode == 200 && response.statusCode == 200) {
      return;
    } else {
      print(response2.statusCode);
      print(response.statusCode);
    }
  }

  @override
  editTeacher(String id, TeacherModel teacher) async {
    var token = await prefService.getToken();
    teacher = TeacherModel(
      username: teacher.username,
      sections: teacher.sections,
      subjectName: teacher.subjectName,
      gender: teacher.gender,
      name: teacher.name,
      password: teacher.password,
    );
    final response = await http.put(Uri.parse("$baseUrl2/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': token
        },
        body: jsonEncode(<String, dynamic>{
          'username': teacher.username,
          'password': teacher.password!,
          'name': teacher.name,
          'gender': teacher.gender,
          'sections': teacher.sections,
          'subjectName': teacher.subjectName,
        }));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to load parent');
    }
  }

  @override
  Future<List<TeacherModel>> getAllTeachers() async {
    var token = await prefService.getToken();
    print("semir");
    final response =
        await http.get(Uri.parse(baseUrl2), headers: {'auth-token': token});
    print("simon");
    List<TeacherModel> responses = [];
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      for (Map<String, dynamic> indiv in decoded) {
        responses.add(TeacherModel.fromJson(indiv));
      }
      return responses;
    }
    throw Exception("some error");
  }

  @override
  Future<TeacherModel> getTeacher(String id) async {
    var token = await prefService.getToken();
    final response = await http
        .get(Uri.parse('$baseUrl2/$id'), headers: {'auth-token': token});
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return TeacherModel.fromJson(decoded);
    }
    throw Exception("Teacher Not Found");
  }

  @override
  deleteTeacher(String id) async {
    var token = await prefService.getToken();
    print(id);
    final response = await http
        .delete(Uri.parse('$baseUrl2/$id'), headers: {'auth-token': token});
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return;
    }
    throw Exception("Parent Not Found");
  }
}
