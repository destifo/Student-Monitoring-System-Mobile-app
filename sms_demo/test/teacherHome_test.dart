import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sms_demo/presentation/teacher/screens/TeacherHome.dart';

void main() {
  testWidgets("test teacher's home page", (WidgetTester tester) async {
    final teacher_name = find.byKey(ValueKey('teacher name'));
    final section_list = find.byKey(ValueKey('list of sections'));

    await tester.pumpWidget(TeacherHome());
    expect('app crashed', findsNothing);
  });
}
