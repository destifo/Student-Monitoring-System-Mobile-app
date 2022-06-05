import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sms_demo/Data/local/shared_preferences/shared_preference_service.dart';
import 'package:sms_demo/Domain/model/teacher/marklist.dart';
import 'package:sms_demo/Domain/model/teacher/parent_model.dart';
import 'marklist_provider.dart';

class MarklistRemoteProvider implements MarklistProvider {
  final _baseUrl = 'http://localhost:5000/api/students';
  final _baseUrl2 = 'http://localhost:5000/api/grades';
  // final subjectName;
  final SharedPreferenceService prefService = SharedPreferenceService();
  // MarklistRemoteProvider(this.subjectName);
  @override
  Future<List<ParentModel>> getSectionStudents(String sectionName) async {
    var token = await prefService.getToken();
    final response =
        await http.get(Uri.parse(_baseUrl), headers: {'auth-token': token});
    List<ParentModel> responses = [];
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      for (Map<String, dynamic> indiv in decoded) {
        ParentModel student = ParentModel.fromJson(indiv);
        if (student.sectionName == sectionName) {
          responses.add(student);
        }
      }
      return responses;
    }
    throw Exception("some error");
  }

  Future<Marklist> getStudentMark(String id) async {
    var subjectName = await prefService.getValueOf('subject');
    var token = await prefService.getToken();
    final response = await http
        .get(Uri.parse("$_baseUrl2/$id"), headers: {'auth-token': token});
    //print(response.body);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return Marklist.fromJson(decoded, subjectName);
    }
    throw Exception("some error");
  }

  @override
  saveMark(Marklist marklist) async {
    var subjectName = await prefService.getValueOf('subject');
    var token = await prefService.getToken();
    await http.put(Uri.parse("$_baseUrl2/students/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': token
        },
        body: jsonEncode(<String, dynamic>{
          "_id": marklist.studentId,
          "mark": {
            "subjectName": subjectName,
            "test1": marklist.testOne,
            "test2": marklist.testTwo,
            "mid": marklist.midTerm,
            "final": marklist.finalExam,
            "assesment": marklist.assesment
          }
        }));
  }

  @override
  Future<List<Marklist>> getStudentTotalGrade(String id) async {
    print("$_baseUrl2/$id");
    var token = await prefService.getToken();
    final response = await http
        .get(Uri.parse("$_baseUrl2/$id"), headers: {'auth-token': token});
    List<Marklist> responses = [];
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print(decoded);
      for (Map indiv in decoded) {
        Marklist marklist = Marklist.fromJsonSubjectLevel(indiv);
        responses.add(marklist);
      }
      return responses;
    }
    throw Exception("some error");
  }
}
