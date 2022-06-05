import 'package:sms_demo/Data/Teacher/data_provider/teacher/teacher_user_remote_provider.dart';
import 'package:sms_demo/Data/Teacher/data_repository/teacher_user_repository.dart';
import 'package:sms_demo/Data/admin/Management/data_provider/teacher_provider/teacher_api_provider.dart';
import 'package:sms_demo/Data/admin/Management/data_repository/TeacherAccRepo/teacher_repo.dart';
import 'package:sms_demo/Data/auth/data_provider/auth_provider.dart';
import 'package:sms_demo/Data/local/shared_preferences/shared_preference_service.dart';
import 'package:sms_demo/Domain/model/auth/user.dart';
import 'package:sms_demo/Domain/model/auth/user_response.dart';

class AuthRepository {
  final AuthProvider authProvider;
  AuthRepository({required this.authProvider});
  final SharedPreferenceService prefService = SharedPreferenceService();

  getUserInfo(User user) async {
    try {
      print("in repo");
      final UserResponse userResponse =
          await authProvider.authenticateUser(user);
      prefService.saveToken(userResponse.token);
      if (userResponse.role == "teacher") {
        prefService.addKeyValuePair('id', userResponse.id);
        final TeacherRepository teacherRepo =
            TeacherRepository(teacherProvider: TeacherApiProvider());
        var teacher = await teacherRepo.getTeacher(userResponse.id);
        var subject = teacher.subjectName;
        prefService.addKeyValuePair('subject', subject);
      }
      if (userResponse.role == 'parent') {
        Future.delayed(const Duration(seconds: 1));
        prefService.addKeyValuePair('id', userResponse.id);
      }
      return userResponse;
    } catch (ex) {
      UserResponse userResponse =
          UserResponse(id: '-1', token: '-1', role: '-1');
      return userResponse;
    }
  }
}
