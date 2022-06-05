import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_demo/Data/admin/Management/data_repository/TeacherAccRepo/teacher_repo.dart';

import '../../Domain/model/admin/Management/teacher_model.dart';
import 'TeacherAccEvent.dart';
import 'TeacherAccState.dart';

class TeacherAccBloc extends Bloc<TeacherAccEvent, TeacherAccState> {
  final TeacherRepository teacherRepository;
  TeacherAccBloc(this.teacherRepository) : super(TeachersLoading()) {
    on<LoadTeacherAccs>(_onLoadTeacherAccs);
    on<AddTeacherAcc>(_onAddTeacherAcc);
    on<UpdateTeacherAcc>(_onUpdateTeacherAcc);
    on<DeleteTeacherAcc>(_onDeleteTeacherAcc);
    on<LoadTeacherAcc>(_onLoadTeacherAcc);
  }

  void _onLoadTeacherAccs(LoadTeacherAccs event, Emitter emit) async {
    try {
      emit(TeachersLoading());
      while (true) {
        await Future.delayed(Duration(seconds: 1));
        final teachers = await teacherRepository.getTeachers();
        emit(TeachersLoaded(teachers));
      }
    } catch (_) {
      emit(TeacherLoadingFailed());
    }
  }

  void _onAddTeacherAcc(AddTeacherAcc event, Emitter emit) async {
    emit(TeacherLoading());
    await teacherRepository.addTeacher(TeacherModel(
        name: event.name,
        username: event.username,
        gender: event.gender,
        sections: event.sections,
        password: event.password,
        subjectName: event.subjectName));
    final teachers = await teacherRepository.getTeachers();
    emit(TeachersLoaded(teachers));
  }

  void _onUpdateTeacherAcc(UpdateTeacherAcc event, Emitter emit) async {
    emit(TeachersLoading());
    await teacherRepository.editTeacher(event.id, event.teacher!);
    final teachers = await teacherRepository.getTeachers();
    await Future.delayed(Duration(seconds: 2));
    emit(TeachersLoaded(teachers));
  }

  void _onDeleteTeacherAcc(DeleteTeacherAcc event, Emitter emit) async {
    emit(TeachersLoading());
    await teacherRepository.deleteTeacher(event.id);
    final teachers = await teacherRepository.getTeachers();
    emit(TeachersLoaded(teachers));
  }

  void _onLoadTeacherAcc(LoadTeacherAcc event, Emitter emit) async {
    emit(TeacherLoading());
    await teacherRepository.getTeacher(event.id);
  }
}
