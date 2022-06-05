// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_demo/Data/admin/Announcement/Repository/announcemnt_repository.dart';

import 'blocs.dart';

class AnnouncemntBloc extends Bloc<AnnouncemntEvent, AnnouncemntState> {
  final AnnouncemntRepository announcemntRepository;
  AnnouncemntBloc({required this.announcemntRepository})
      : super(AnnouncemntLoading()) {
    on<AnnouncemntLoad>((event, emit) async {
      emit(AnnouncemntLoading());
      try {
        final announcemnts = await announcemntRepository.getAnnouncemnts();
        print(announcemnts);
        emit(AnnouncemntLoadSuccess(announcemnts));
      } catch (error) {
        print(error);
        emit(AnnouncemntOperationFailure());
      }
    });
  }
}
