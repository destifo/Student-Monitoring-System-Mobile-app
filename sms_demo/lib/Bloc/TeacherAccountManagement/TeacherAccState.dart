import '../../Domain/model/admin/Management/teacher_model.dart';

abstract class TeacherAccState{}
class TeachersLoading extends TeacherAccState{}
class TeachersLoaded extends TeacherAccState{
  List<TeacherModel> teachers;
  TeachersLoaded(this.teachers);
}
class TeachersLoadingFailed extends TeacherAccState{}


class TeacherLoading extends TeacherAccState{}
class TeacherLoaded extends TeacherAccState{
  final TeacherModel teacher;
  TeacherLoaded(this.teacher);
}
class TeacherLoadingFailed extends TeacherAccState{}
