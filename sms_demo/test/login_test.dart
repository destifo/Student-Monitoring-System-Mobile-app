import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sms_demo/Bloc/auth/auth_event.dart';
import 'package:sms_demo/main.dart';
import 'package:sms_demo/presentation/auth/login_screen.dart';

void main() {
  testWidgets('login test', (WidgetTester tester) async {
    final username = find.byKey(ValueKey('username'));
    final password = find.byKey(ValueKey('password'));
    final submit = find.byKey(ValueKey('login'));

    await tester.pumpWidget(MaterialApp(home: SmsDemo()));
    await tester.enterText(username, '');
    await tester.enterText(password, '');
    await tester.tap(submit);
    await tester.pump();
    expect(find.text('password must not be empty'), findsOneWidget);
    expect(find.text('Username must not be empty'), findsOneWidget);
  });
}
