import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_demo/Bloc/ParentAccountManagement/ParAccEvent.dart';
import 'package:sms_demo/Bloc/ParentAccountManagement/ParrAccState.dart';
import 'package:sms_demo/Data/admin/Management/data_repository/ParentAccRepo/parent_repo.dart';
import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';

class ParAccBloc extends Bloc<ParAccEvent, ParrAccState> {
  final ParentRepository parentRepository;
  ParAccBloc(this.parentRepository) : super(ParentsLoading()) {
    on<LoadParAccs>(_onLoadParrAccs);
    on<AddParAcc>(_onAddParAcc);
    on<UpdateParAcc>(_onUpdateParAcc);
    on<DeleteParAcc>(_onDeleteParAcc);
    on<LoadParAcc>(_onLoadParAcc);
  }

  void _onLoadParrAccs(LoadParAccs event, Emitter emit) async {
    try {
      emit(ParentsLoading());
      while (true) {
        await Future.delayed(Duration(seconds: 1));
        final parents = await parentRepository.getParents();
        emit(ParentsLoaded(parents));
      }
    } catch (_) {
      emit(ParentLoadingFailed());
    }
  }

  void _onAddParAcc(AddParAcc event, Emitter emit) async {
    try {
      emit(ParentsLoading());
      await parentRepository.addParent(ParentModel(
        name: event.name,
        username: event.username,
        gender: event.gender,
        sectionName: event.sectionName,
        password: event.password,
      ));
      final parents = await parentRepository.getParents();
      emit(ParentsLoaded(parents));
    } catch (_) {
      ParentsLoadingFailed();
    }
  }

  void _onUpdateParAcc(UpdateParAcc event, Emitter emit) async {
    try {
      emit(ParentsLoading());
      await parentRepository.editParent(event.id, event.parent!);
      final parents = await parentRepository.getParents();
      emit(ParentsLoaded(parents));
    } catch (_) {
      emit(ParentLoadingFailed());
    }
  }

  void _onDeleteParAcc(DeleteParAcc event, Emitter emit) async {
    emit(ParentsLoading());
    try {
      await parentRepository.deleteParrent(event.id);
      final parents = await parentRepository.getParents();
      emit(ParentsLoaded(parents));
    } catch (_) {
      emit(ParentLoadingFailed());
    }
  }

  void _onLoadParAcc(LoadParAcc event, Emitter emit) async {
    emit(ParentsLoading());
    await parentRepository.getParrent(event.id);
  }
}
