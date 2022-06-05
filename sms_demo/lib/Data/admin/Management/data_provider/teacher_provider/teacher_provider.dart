import 'package:sms_demo/Domain/model/admin/Management/teacher_model.dart';

abstract class TeacherProvider {
  Future addTeacher(TeacherModel teacher);
  editTeacher(String id, TeacherModel teacherModel);
  Future<TeacherModel> getTeacher(String id);
  Future<List<TeacherModel>> getAllTeachers();
  deleteTeacher(String id);
}
