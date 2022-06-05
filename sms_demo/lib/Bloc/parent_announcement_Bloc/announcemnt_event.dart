import 'package:equatable/equatable.dart';

abstract class AnnouncemntEvent extends Equatable {
  const AnnouncemntEvent();
}

class AnnouncemntLoad extends AnnouncemntEvent {
  const AnnouncemntLoad();

  @override
  List<Object> get props => [];
}
