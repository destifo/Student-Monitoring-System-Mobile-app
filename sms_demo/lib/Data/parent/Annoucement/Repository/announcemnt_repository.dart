import 'package:sms_demo/Domain/model/admin/Announcement/models.dart';

import '../Data_Provider/announcemnt_provider.dart';

class AnnouncemntRepository {
  final AnnouncemntDataProvider dataProvider;

  AnnouncemntRepository({required this.dataProvider});
  Future<List<Announcemnt>> getAnnouncemnts() async {
    print("came here");
    return await dataProvider.getAnnouncemnts();
  }
}
