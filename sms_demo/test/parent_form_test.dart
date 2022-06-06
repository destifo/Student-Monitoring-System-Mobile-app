import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sms_demo/Bloc/auth/auth_event.dart';
import 'package:sms_demo/main.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/parent_form.dart';
import 'package:sms_demo/presentation/auth/login_screen.dart';

void main() {
  testWidgets('parent form', (WidgetTester tester) async {
    final username = find.byKey(ValueKey('parentusername'));
    final name = find.byKey(ValueKey('parentname'));
    final password = find.byKey(ValueKey('parentpassword'));
    final submit = find.byKey(ValueKey('parentsubmit'));
    final section = find.byKey(ValueKey('parentsectionname'));

    await tester.pumpWidget(MaterialApp(
        home: ParentForm(
      status: 0,
    )));
    await tester.enterText(name, 'yoseph');
    await tester.pumpAndSettle();

    // await tester.enterText(name, '');
    // await tester.pumpAndSettle();
    // await tester.enterText(password, '');
    // await tester.pumpAndSettle();
    // await tester.enterText(section, '');
    // await tester.pumpAndSettle();
    await tester.tap(submit);
    await tester.pump(Duration(seconds: 3));
    expect(find.text('Please enter some valid name'), findsNothing);
    // expect(find.text('Please enter some valid username'), findsOneWidget);
    // expect(find.text('Please enter some valid password'), findsOneWidget);
    // expect(find.text('Please enter some valid section number'), findsOneWidget);
  });
}
