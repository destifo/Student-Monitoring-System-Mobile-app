import '../../Domain/model/admin/Management/teacher_model.dart';

abstract class TeacherAccEvent {}

class LoadTeacherAccs extends TeacherAccEvent {}

class AddTeacherAcc extends TeacherAccEvent {
  String name;
  String gender;
  List<String> sections;
  String subjectName;
  String password;
  String username;

  AddTeacherAcc(
      {required this.name,
      required this.gender,
      required this.sections,
      required this.password,
      required this.subjectName,
      required this.username});
}

class UpdateTeacherAcc extends TeacherAccEvent {
  final TeacherModel? teacher;
  String id;
  UpdateTeacherAcc({required this.id, this.teacher});
}

class DeleteTeacherAcc extends TeacherAccEvent {
  final String id;
  DeleteTeacherAcc({required this.id});
}

class LoadTeacherAcc extends TeacherAccEvent {
  final String id;
  LoadTeacherAcc(this.id);
}
