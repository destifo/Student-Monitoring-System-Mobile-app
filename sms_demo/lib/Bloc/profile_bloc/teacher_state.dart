part of 'teacher_bloc.dart';

abstract class Teacher_state {
  get teacher => null;
}

class TeacherLoaded extends Teacher_state {
  TeacherModel teacher;
  TeacherLoaded(this.teacher);
}

class TeacherLoading extends Teacher_state {}

class TeacherFailure extends Teacher_state {}
