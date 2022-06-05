import 'dart:convert';

import 'package:sms_demo/Data/admin/Management/data_provider/parent_provider/parent_provider.dart';
import 'package:sms_demo/Data/local/shared_preferences/shared_preference_service.dart';
import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';
import 'package:http/http.dart' as http;

class ParentApiProvider implements ParentProvider {
  String baseUrl = "http://localhost:5000/api/users";
  String baseUrl2 = "http://localhost:5000/api/students";
  final SharedPreferenceService prefService = SharedPreferenceService();
  // var token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjliMjQ5MWI1NTFmNjQ0MDg0MmY2MjIiLCJpYXQiOjE2NTQzMzQ3MzZ9.5nK5sxc-49X5u_l7rlP1rNJPWpDSs07QzwWuUWpgP8Y";
  @override
  Future addParent(ParentModel parent) async {
    var token = await prefService.getToken();
    ParentModel parent2 = ParentModel(
      username: parent.username,
      sectionName: parent.sectionName,
      gender: parent.gender,
      name: parent.name,
      password: parent.password,
    );
    print("${parent2.gender} ${parent2.username}");
    final response = await http.post(Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': token
        },
        body: jsonEncode(<String, String>{
          'username': parent2.username,
          'password': parent2.password!,
          'role': 'parent',
        }));
    final response2 = await http.post(
      Uri.parse(baseUrl2),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': token
      },
      body: jsonEncode(<String, String>{
        'sectionName': parent2.sectionName,
        'name': parent2.name,
        'username': parent2.username,
        'gender': parent2.gender,
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
  editParrent(String id, ParentModel parent) async {
    var token = await prefService.getToken();
    parent = ParentModel(
      username: parent.username,
      sectionName: parent.sectionName,
      gender: parent.gender,
      name: parent.name,
      password: parent.password,
    );
    final response = await http.put(Uri.parse("$baseUrl2/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': token
        },
        body: jsonEncode(<String, String>{
          'username': parent.username,
          'password': parent.password!,
          'name': parent.name,
          'gender': parent.gender,
          'sectionName': parent.sectionName
        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to load parent');
    }
  }

  @override
  Future<List<ParentModel>> getAllParents() async {
    var token = await prefService.getToken();
    final response =
        await http.get(Uri.parse(baseUrl2), headers: {'auth-token': token});

    List<ParentModel> responses = [];
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      for (Map<String, dynamic> indiv in decoded) {
        responses.add(ParentModel.fromJson(indiv));
      }
      print(responses);
      return responses;
    }
    throw Exception("some error");
  }

  @override
  Future<ParentModel> getParent(String id) async {
    var token = await prefService.getToken();
    final response = await http
        .get(Uri.parse('$baseUrl2/$id'), headers: {'auth-token': token});
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return ParentModel.fromJson(decoded);
    }
    throw Exception("Parent Not Found");
  }

  @override
  deleteParent(String id) async {
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
