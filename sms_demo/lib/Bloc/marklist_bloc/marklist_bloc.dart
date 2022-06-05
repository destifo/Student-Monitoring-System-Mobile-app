import 'package:bloc/bloc.dart';
import 'package:sms_demo/Data/Teacher/data_repository/marklist_repository.dart';
import 'package:sms_demo/Domain/model/teacher/marklist.dart';
import 'package:sms_demo/Domain/model/teacher/parent_model.dart';

part 'marklist_event.dart';
part 'marklist_state.dart';

class MarklistBloc extends Bloc<MarklistEvent, MarklistState> {
  final MarklistRepository marklistRepository;
  MarklistBloc(this.marklistRepository) : super(Operating()) {
    on<Edit>(_onEdit);
    on<GetSectionStudents>(_onGetSectionStudents);
    on<GetStudentMark>(_onGetStudentMark);
  }
  void _onEdit(Edit event, Emitter emit) async {
    emit(Operating());
    final marklist = Marklist(
        assesment: event.assesment,
        finalExam: event.finalExam,
        testOne: event.testOne,
        testTwo: event.testTwo,
        midTerm: event.midTerm,
        studentId: event.studentId);
    marklistRepository.saveMark(marklist);
    emit(OperationSuccess());
  }

  void _onGetSectionStudents(GetSectionStudents event, Emitter emit) async {
    emit(Operating());
    List<ParentModel> parents =
        await marklistRepository.getSectionStudents(event.SectionName);
    await Future.delayed(Duration(seconds: 1));
    emit(StudentsReturned(parents));
  }

  void _onGetStudentMark(GetStudentMark event, Emitter emit) async {
    emit(Operating());
    Marklist studentMark = await marklistRepository.getStudentMark(event.id!);
    print(studentMark);
    await Future.delayed(Duration(seconds: 1));
    emit(StudentMarkReturned(studentMark));
  }
}
