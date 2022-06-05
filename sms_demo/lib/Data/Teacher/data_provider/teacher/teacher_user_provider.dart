import 'package:sms_demo/Domain/model/teacher/teacher.dart';

abstract class TeacherUserProvider {
  Future<TeacherModel> getTeacher();
}
