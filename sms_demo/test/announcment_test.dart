import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sms_demo/Bloc/auth/auth_event.dart';
import 'package:sms_demo/main.dart';
import 'package:sms_demo/presentation/Admin/screens/Announcement/CreateAnnouncement.dart';
import 'package:sms_demo/presentation/Admin/screens/Announcement/announcement.dart';
import 'package:sms_demo/presentation/auth/login_screen.dart';

void main() {
  testWidgets('login test', (WidgetTester tester) async {
    final title = find.byKey(ValueKey('annTitle'));
    final body = find.byKey(ValueKey('body'));
    final submit = find.byKey(ValueKey('submit'));

    await tester.pumpWidget(MaterialApp(home: CreateAnnouncement()));
    await tester.enterText(title, '');
    await tester.enterText(body, '');
    await tester.tap(submit);
    await tester.pump();
    expect(find.text('body must not be empty'), findsOneWidget);
    expect(find.text('title must not be empty'), findsOneWidget);
  });
}
