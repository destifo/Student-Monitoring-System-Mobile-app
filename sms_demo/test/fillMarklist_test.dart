import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sms_demo/main.dart';
import 'package:sms_demo/presentation/teacher/screens/PopUpMarlist.dart';

void main() {
  testWidgets('test one invalid input', (WidgetTester tester) async {
    final test_one = find.byKey(ValueKey('test1'));
    final fill_mark = find.byKey(ValueKey('fill mark'));

    await tester.pumpWidget(PopUpMarklist(
      id: '',
    ));
    await tester.enterText(test_one, '12');
    await tester.tap(fill_mark);
    await tester.pump();
    expect(find.text('please put the extra marks in the other section'),
        findsOneWidget);
    expect(find.text('please fill the result if no result just put 0.0'),
        findsNothing);
  });
  testWidgets('invalid input for testtwo', (WidgetTester tester) async {
    final test_two = find.byKey(ValueKey('test2'));
    final fill_mark = find.byKey(ValueKey('fillmark'));

    await tester.pumpWidget(PopUpMarklist(id: 'someid'));
    await tester.enterText(test_two, '12');
    await tester.tap(fill_mark);
    await tester.pump();
    expect(find.text('please put the extra marks in the other section'),
        findsOneWidget);
    expect(find.text('please fill the result if no result just put 0.0'),
        findsNothing);
  });

  testWidgets('midterm invalid input', (WidgetTester tester) async {
    final mid_term = find.byKey(ValueKey('midterm'));

    final fill_mark = find.byKey(ValueKey('fillmark'));

    await tester.pumpWidget(PopUpMarklist(
      id: '',
    ));
    await tester.enterText(mid_term, '22');
    await tester.tap(fill_mark);
    await tester.pump();
    expect(find.text('please put the extra marks in the other section'),
        findsOneWidget);
    expect(find.text('please fill the result if no result just put 0.0'),
        findsNothing);
  });
  testWidgets('final test invalid input', (WidgetTester tester) async {
    final final_exam = find.byKey(ValueKey('final'));
    final fill_mark = find.byKey(ValueKey('fillmark'));

    await tester.pumpWidget(SmsDemo());
    await tester.enterText(final_exam, '52');
    await tester.tap(fill_mark);
    await tester.pump();
    expect(find.text('please put the extra marks in the other section'),
        findsOneWidget);
    expect(find.text('please fill the result if no result just put 0.0'),
        findsNothing);
  });
  testWidgets('midterm invalid input', (WidgetTester tester) async {
    final mid_term = find.byKey(ValueKey('midterm'));
    final fill_mark = find.byKey(ValueKey('fillmark'));

    await tester.pumpWidget(PopUpMarklist(id: ''));
    await tester.enterText(mid_term, '22');
    await tester.tap(fill_mark);
    await tester.pump();
    expect(find.text('please put the extra marks in the other section'),
        findsOneWidget);
    expect(find.text('please fill the result if no result just put 0.0'),
        findsWidgets);
  });
  testWidgets('other valid input', (WidgetTester tester) async {
    final other = find.byKey(ValueKey('other'));
    final fill_mark = find.byKey(ValueKey('fillmark'));

    await tester.pumpWidget(PopUpMarklist(
      id: '',
    ));
    await tester.enterText(other, '52');
    await tester.tap(fill_mark);
    await tester.pump();
    expect(find.text('please put the extra marks in the other section'),
        findsNothing);
    expect(find.text('please fill the result if no result just put 0.0'),
        findsNothing);
  });
  testWidgets('all valid test', (WidgetTester tester) async {
    final test_one = find.byKey(ValueKey('test1'));
    final final_exam = find.byKey(ValueKey('final'));
    final test_two = find.byKey(ValueKey('test2'));
    final mid_term = find.byKey(ValueKey('midterm'));
    final other = find.byKey(ValueKey('other'));
    final fill_mark = find.byKey(ValueKey('fillmark'));

    await tester.pumpWidget(PopUpMarklist(
      id: '',
    ));
    await tester.enterText(test_one, '9');
    await tester.enterText(test_two, '9');
    await tester.enterText(other, '9');
    await tester.enterText(final_exam, '9');
    await tester.enterText(mid_term, '9');
    await tester.tap(fill_mark);
    await tester.pump();
    expect(find.text('please put the extra marks in the other section'),
        findsNothing);
    expect(find.text('please fill the result if no result just put 0.0'),
        findsNothing);
  });
}
