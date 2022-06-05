part of 'marklist_bloc.dart';

abstract class MarklistState {}

class OperationSuccess extends MarklistState {}

class Operating extends MarklistState {}

class OperatingFailure extends MarklistState {}

class StudentsReturned extends MarklistState {
  List<ParentModel> students;
  StudentsReturned(this.students);
}

class StudentMarkReturned extends MarklistState {
  Marklist studentMark;
  StudentMarkReturned(this.studentMark);
}
