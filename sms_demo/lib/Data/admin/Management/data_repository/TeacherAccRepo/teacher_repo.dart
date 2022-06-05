
import 'package:sms_demo/Data/admin/Management/data_provider/teacher_provider/teacher_provider.dart';
import 'package:sms_demo/Domain/model/admin/Management/teacher_model.dart';

class TeacherRepository{
  TeacherProvider teacherProvider;
  TeacherRepository({required this.teacherProvider});
  Future<List<TeacherModel>> getTeachers(){
    return teacherProvider.getAllTeachers();
  }

  addTeacher(TeacherModel teacherModel){
      teacherProvider.addTeacher(teacherModel);
  }
  editTeacher(String id, TeacherModel teacherModel){
    teacherProvider.editTeacher(id, teacherModel);
  }
  deleteTeacher(String id){
    teacherProvider.deleteTeacher(id);
  }
  getTeacher(String id){
    return teacherProvider.getTeacher(id);
  }
}