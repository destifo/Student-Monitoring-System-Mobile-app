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

    on<AnnouncemntCreate>((event, emit) async {
      try {
        print(event.announcemnt);
        await announcemntRepository.createAnnouncemnt(event.announcemnt);
        final announcemnts = await announcemntRepository.getAnnouncemnts();
        emit(AnnouncemntLoadSuccess(announcemnts));
      } catch (error) {
        print(error);
        emit(AnnouncemntOperationFailure());
      }
    });

    on<AnnouncemntDelete>((event, emit) async {
      try {
        await announcemntRepository.deleteAnnouncemnt(event.announcemnt);
        print("delete successssssssssssssssssssssss");
        Future.delayed(Duration(seconds: 2));
        final announcemnts = await announcemntRepository.getAnnouncemnts();
        print(announcemnts);
        emit(AnnouncemntLoadSuccess(announcemnts));
      } catch (error) {
        print(error);
        emit(AnnouncemntOperationFailure());
      }
    });

    on<AnnouncemntUpdate>((event, emit) async {
      try {
        await announcemntRepository.updateAnnouncemnt(event.announcemnt);
        final announcemnts = await announcemntRepository.getAnnouncemnts();
        emit(AnnouncemntLoadSuccess(announcemnts));
      } catch (error) {
        emit(AnnouncemntOperationFailure());
      }
    });
  }
}
