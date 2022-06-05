import 'package:equatable/equatable.dart';
import 'package:sms_demo/Domain/model/admin/Announcement/announcemnt_model.dart';


abstract class AnnouncemntEvent extends Equatable {
  const AnnouncemntEvent();
}

class AnnouncemntLoad extends AnnouncemntEvent {
  const AnnouncemntLoad();

  @override
  List<Object> get props => [];
}

class AnnouncemntCreate extends AnnouncemntEvent {
  final Announcemnt announcemnt;
  const AnnouncemntCreate(this.announcemnt);

  @override
  List<Object> get props => [announcemnt];

  @override
  String toString() => 'Announcemnt Createe {announcemnt: $announcemnt}';
}

class AnnouncemntUpdate extends AnnouncemntEvent {
  final Announcemnt announcemnt;
  const AnnouncemntUpdate(this.announcemnt);

  @override
  List<Object> get props => [announcemnt];

  @override
  String toString() => "Announcemnt updated {announcemnt : $announcemnt}";
}

class AnnouncemntDelete extends AnnouncemntEvent {
  final Announcemnt announcemnt;
  const AnnouncemntDelete(this.announcemnt);

  @override
  List<Object> get props => [announcemnt];
}
