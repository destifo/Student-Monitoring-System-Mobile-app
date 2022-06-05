// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:sms_demo/Domain/model/admin/Announcement/announcemnt_model.dart';

class AnnouncemntState extends Equatable {
  const AnnouncemntState();

  @override
  List<Object> get props => [];
}

class AnnouncemntLoading extends AnnouncemntState {}

class AnnouncemntLoadSuccess extends AnnouncemntState {
  final List<Announcemnt> announcemnts;

  AnnouncemntLoadSuccess([this.announcemnts = const []]);

  @override
  List<Object> get props => [announcemnts];
}

class AnnouncemntOperationFailure extends AnnouncemntState {}
