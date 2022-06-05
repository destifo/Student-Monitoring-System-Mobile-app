import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:sms_demo/Data/Teacher/data_repository/teacher_user_repository.dart';
import 'package:sms_demo/Domain/model/teacher/teacher.dart';
part 'teacher_event.dart';
part 'teacher_state.dart';

// ignore: camel_case_types
class Teacher_bloc extends Bloc<Teacher_event, Teacher_state> {
  final TeacherUserRepository teacherRepository;
  Teacher_bloc(this.teacherRepository) : super(TeacherLoading()) {
    on<LoadTeacher>(_loadTeacher);
  }
  void _loadTeacher(LoadTeacher event, Emitter emit) async {
    emit(TeacherLoading());
    final teacher = await teacherRepository.getTeacher();
    emit(TeacherLoaded(teacher));
  }
}
