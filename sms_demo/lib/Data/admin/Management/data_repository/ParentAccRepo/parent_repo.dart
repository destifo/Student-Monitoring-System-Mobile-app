import 'package:sms_demo/Data/admin/Management/data_provider/parent_provider/parent_provider.dart';
import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';

class ParentRepository {
  ParentProvider parentProvider;
  ParentRepository({required this.parentProvider});
  Future<List<ParentModel>> getParents() {
    return parentProvider.getAllParents();
  }

  addParent(ParentModel parentModel) {
    parentProvider.addParent(parentModel);
  }

  editParent(String id, ParentModel parentModel) {
    parentProvider.editParrent(id, parentModel);
  }

  deleteParrent(String id) {
    parentProvider.deleteParent(id);
  }

  getParrent(String id) {
    return parentProvider.getParent(id);
  }
}
