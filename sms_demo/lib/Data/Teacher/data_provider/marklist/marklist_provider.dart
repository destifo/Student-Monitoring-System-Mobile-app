import 'package:sms_demo/Domain/model/teacher/marklist.dart';
import 'package:sms_demo/Domain/model/teacher/parent_model.dart';

abstract class MarklistProvider {
  Future<List<ParentModel>> getSectionStudents(String sectionName);
  Future<Marklist> getStudentMark(String id);
  Future saveMark(Marklist marklist);
  Future<List<Marklist>> getStudentTotalGrade(String id);
}
