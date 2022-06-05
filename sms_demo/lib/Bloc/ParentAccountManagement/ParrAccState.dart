import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';

abstract class ParrAccState{}

class ParentsLoading extends ParrAccState{}
class ParentsLoaded extends ParrAccState{
  List<ParentModel> parents;
  ParentsLoaded(this.parents);
}
class ParentsLoadingFailed extends ParrAccState{}

class ParentLoading extends ParrAccState{}
class ParentLoaded extends ParrAccState{
  final ParentModel parent;
  ParentLoaded(this.parent);
}
class ParentLoadingFailed extends ParrAccState{}
