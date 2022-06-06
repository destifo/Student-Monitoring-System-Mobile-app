import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_demo/Bloc/marklist_bloc/marklist_bloc.dart';
import 'package:sms_demo/Data/Teacher/data_repository/marklist_repository.dart';
import 'package:sms_demo/Data/local/shared_preferences/shared_preference_service.dart';
import 'package:sms_demo/Domain/model/teacher/marklist.dart';
import 'package:sms_demo/presentation/teacher/screens/FillMark.dart';
import 'package:sms_demo/presentation/teacher/screens/PopUpMarlist.dart';

class MockMarklist extends Mock implements MarklistRepository {}

class MarklistTest extends Mock implements Marklist {}

void main() {
  Marklist marklist =
      Marklist(finalExam: 30, testOne: 8, testTwo: 5, midTerm: 5, assesment: 4);

  testWidgets('test mark', (tester) async {
    final client = MockMarklist();

    final widget = PopUpMarklist(
      marklist: marklist,
      id: 'id',
    );
    when(client.saveMark(Marklist(
            finalExam: 30, testOne: 8, testTwo: 5, midTerm: 5, assesment: 4)))
        .thenAnswer((realInvocation) {});
    await tester.pumpWidget(widget);
    expect(find.byType(TextFormField), findsNothing);
  });
}
