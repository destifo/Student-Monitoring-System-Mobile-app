import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';

abstract class ParAccEvent{}

class LoadParAccs extends ParAccEvent{}

class AddParAcc extends ParAccEvent{
  String name;
  String gender;
  String sectionName;
  String password;
  String username;

  AddParAcc({required this.name, required this.gender, required this.sectionName, required this.password, required this.username});
}
class UpdateParAcc extends ParAccEvent{
  final ParentModel? parent;
  String id;
  UpdateParAcc({required this.id,this.parent});
}

class DeleteParAcc extends ParAccEvent{
  final String id;
  DeleteParAcc({required this.id});
}
class LoadParAcc extends ParAccEvent{
  final String id;
  LoadParAcc(this.id);
}