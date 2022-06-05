import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';

abstract class ParentProvider{
  Future addParent(ParentModel parent);
  editParrent(String id, ParentModel parentModel);
  Future<ParentModel> getParent(String id);
  Future<List<ParentModel>> getAllParents();
  deleteParent(String id);
}