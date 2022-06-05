part of 'marklist_bloc.dart';

abstract class MarklistEvent {}

class Edit extends MarklistEvent {
  int testOne;
  int testTwo;
  int assesment;
  int midTerm;
  int finalExam;
  String? studentId;
  Edit({
    required this.testOne,
    required this.testTwo,
    required this.midTerm,
    required this.finalExam,
    required this.assesment,
    required this.studentId,
  });
}

class GetSectionStudents extends MarklistEvent {
  String SectionName;
  GetSectionStudents(this.SectionName);
}

class GetStudentMark extends MarklistEvent {
  String? id;
  GetStudentMark(this.id);
}

class Idle extends MarklistEvent {}
