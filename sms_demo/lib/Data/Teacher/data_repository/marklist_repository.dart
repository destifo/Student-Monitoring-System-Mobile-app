import 'package:sms_demo/Domain/model/teacher/marklist.dart';
import 'package:sms_demo/Domain/model/teacher/parent_model.dart';

import '../data_provider/marklist/marklist_provider.dart';

class MarklistRepository {
  final MarklistProvider marklistProvider;

  MarklistRepository(this.marklistProvider);

  Future<List<ParentModel>> getSectionStudents(String sectionId) async {
    return await marklistProvider.getSectionStudents(sectionId);
  }

  Future<Marklist> getStudentMark(String id) {
    return marklistProvider.getStudentMark(id);
  }

  void saveMark(Marklist marklist) async {
    await marklistProvider.saveMark(marklist);
  }

  Future<List<Marklist>> getStudentTotalGrade(String studentId) async {
    final marklists = await marklistProvider.getStudentTotalGrade(studentId);
    return marklists;
  }
}
