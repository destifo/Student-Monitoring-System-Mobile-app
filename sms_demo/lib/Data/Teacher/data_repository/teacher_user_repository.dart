import 'package:sms_demo/Data/Teacher/data_provider/teacher/teacher_user_provider.dart';
import 'package:sms_demo/Domain/model/teacher/teacher.dart';

class TeacherUserRepository {
  final TeacherUserProvider teacherProvider;

  TeacherUserRepository({
    required this.teacherProvider,
  });
  Future<TeacherModel> getTeacher() async {
    return await teacherProvider.getTeacher();
  }
}
