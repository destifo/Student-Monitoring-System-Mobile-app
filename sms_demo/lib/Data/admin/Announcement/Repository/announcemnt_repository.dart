import 'package:meta/meta.dart';
import 'package:sms_demo/Data/admin/Announcement/DataProvider/announcemnt_provider.dart';
import 'package:sms_demo/Domain/model/admin/Announcement/models.dart';

class AnnouncemntRepository {
  final AnnouncemntDataProvider dataProvider;

  AnnouncemntRepository({required this.dataProvider});

  Future<Announcemnt> createAnnouncemnt(Announcemnt announcemnt) async {
    return await dataProvider.createAnnouncemnt(announcemnt);
  }

  Future<List<Announcemnt>> getAnnouncemnts() async {
    print("came here");
    return await dataProvider.getAnnouncemnts();
  }

  Future<void> updateAnnouncemnt(Announcemnt announcemnt) async {
    await dataProvider.updateAnnouncemnts(announcemnt);
  }

  Future<void> deleteAnnouncemnt(Announcemnt announcemnt) async {
    print('delete here is loading');
    await dataProvider.deleteAnnouncemnt(announcemnt.id);
  }
}
