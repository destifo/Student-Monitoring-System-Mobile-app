// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sms_demo/Data/local/shared_preferences/shared_preference_service.dart';
import 'package:sms_demo/Domain/model/admin/Announcement/models.dart';

class AnnouncemntDataProvider {
  final _baseUrl = 'http://localhost:5000/api/announcement';
  SharedPreferenceService prefService = SharedPreferenceService();
  final http.Client httpClient;

  AnnouncemntDataProvider({required this.httpClient});

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
}
