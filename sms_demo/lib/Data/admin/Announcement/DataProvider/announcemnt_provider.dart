// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sms_demo/Domain/model/admin/Announcement/models.dart';

import '../../../local/shared_preferences/shared_preference_service.dart';

class AnnouncemntDataProvider {
  final _baseUrl = 'http://localhost:5000/api/announcement';
  // String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjliMjQ5MWI1NTFmNjQ0MDg0MmY2MjIiLCJpYXQiOjE2NTQzMzk2NTB9.fuOsSZf8DYSqOZ2Wr-5_RVBh4NmpVujU4tWTUyMZ3t4";
  final http.Client httpClient;
  final SharedPreferenceService prefService = SharedPreferenceService();

  AnnouncemntDataProvider({required this.httpClient});

  Future<Announcemnt> createAnnouncemnt(Announcemnt announcemnt) async {
    var token = await prefService.getToken();
    final http.Response response = await httpClient.post(
      Uri.parse('$_baseUrl/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': token,
      },
      body: jsonEncode(<String, dynamic>{
        'title': announcemnt.title,
        'body': announcemnt.body,
      }),
    );
    print(response.body);
    print(announcemnt.title);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Announcemnt.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Announcemnt');
    }
  }

  Future<List<Announcemnt>> getAnnouncemnts() async {
    var token = await prefService.getToken();
    final response =
        await httpClient.get(Uri.parse('$_baseUrl/'), headers: <String, String>{
      'auth-token': token,
    });
    print(response.body);
    if (response.statusCode == 200) {
      final announcemnts = jsonDecode(response.body) as List;
      return announcemnts
          .map((announcemnt) => Announcemnt.fromJson(announcemnt))
          .toList();
    } else {
      throw Exception('Failed to load announcemnts');
    }
  }

  Future<void> deleteAnnouncemnt(String? id) async {
    var token = await prefService.getToken();
    final http.Response response = await httpClient.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': token,
      },
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      print(response.statusCode);
      throw Exception('Failed to delete course.');
    }
  }

  Future<void> updateAnnouncemnts(Announcemnt announcemnt) async {
    var token = await prefService.getToken();
    print('came all down here');
    final http.Response response = await httpClient.put(
      Uri.parse('$_baseUrl/${announcemnt.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': token,
      },
      body: jsonEncode(<String, dynamic>{
        'title': announcemnt.title,
        'body': announcemnt.body,
      }),
    );
    print(response.body);
    if (response.statusCode != 200) {
      print('happened here');
      throw Exception('Failed to update course.');
    }
  }
}
