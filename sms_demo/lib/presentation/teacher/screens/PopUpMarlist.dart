import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Bloc/marklist_bloc/marklist_bloc.dart';
import 'package:sms_demo/Domain/model/teacher/marklist.dart';
import 'package:sms_demo/presentation/teacher/screens/TeacherHome.dart';

class PopUpMarklist extends StatefulWidget {
  String id;
  Marklist? marklist;
  PopUpMarklist({Key? key, required this.id, this.marklist}) : super(key: key);

  @override
  State<PopUpMarklist> createState() => _PopUpMarklistState();
}

class _PopUpMarklistState extends State<PopUpMarklist> {
  final formKey = GlobalKey<FormState>();

  final testOneController = TextEditingController();

  final testTwoController = TextEditingController();

  final midTermController = TextEditingController();

  final finalController = TextEditingController();

  final assesmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarklistBloc, MarklistState>(
      listener: (context, state) {
        if (state is StudentMarkReturned) {
          testOneController.text = state.studentMark.testOne.toString();
          testTwoController.text = state.studentMark.testTwo.toString();
          assesmentController.text = state.studentMark.assesment.toString();
          midTermController.text = state.studentMark.midTerm.toString();
          finalController.text = state.studentMark.finalExam.toString();
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: testOneController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 84, 81, 71),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Test one (10%)',
                    focusColor: Color.fromARGB(255, 84, 81, 71),
                  ),
                  validator: (String? testOne) {
                    if (testOne == null || testOne.isEmpty) {
                      return 'please fill the result if no result just put 0.0';
                    }
                    var test10 = double.parse(testOne);
                    if (test10 > 10) {
                      return 'please put the extra marks in the other section';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: midTermController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 84, 81, 71),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Mid Term (20%)',
                    focusColor: Color.fromARGB(255, 84, 81, 71),
                  ),
                  validator: (String? midTerm) {
                    if (midTerm == null || midTerm.isEmpty) {
                      return 'please fill the result if no result just put 0.0';
                    }
                    var mid = double.parse(midTerm);
                    if (mid > 20) {
                      return "please put the extra marks in the 'other' section";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: testTwoController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 84, 81, 71),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Test two (10%)',
                    focusColor: Color.fromARGB(255, 84, 81, 71),
                  ),
                  validator: (String? testTwo) {
                    if (testTwo == null || testTwo.isEmpty) {
                      return 'please fill the result if no result just put 0.0';
                    }
                    var test10 = double.parse(testTwo);
                    if (test10 > 10) {
                      return 'please put the extra marks in the other section';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: assesmentController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 84, 81, 71),
                  ),
                  decoration: const InputDecoration(
                    hintText: "assesment out of 15",
                    focusColor: Color.fromARGB(255, 84, 81, 71),
                  ),
                  validator: (String? other) {
                    if (other == null || other.isEmpty) {
                      return 'please fill the result if no result just put 0.0';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: finalController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 84, 81, 71),
                  ),
                  decoration: const InputDecoration(
                    hintText: "final exam",
                    focusColor: Color.fromARGB(255, 84, 81, 71),
                  ),
                  validator: (String? finalExam) {
                    if (finalExam == null || finalExam.isEmpty) {
                      return 'please fill the result if no result just put 0.0';
                    }
                    var final45 = double.parse(finalExam);
                    if (final45 > 45) {
                      return 'please put the extra marks in the other section';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 106, 104, 99)),
                  ),
                  onPressed: () {
                    final formValid = formKey.currentState!.validate();
                    if (!formValid) return;

                    final marklistBloc = BlocProvider.of<MarklistBloc>(context);
                    marklistBloc.add(Edit(
                        studentId: widget.id,
                        testOne: int.parse(testOneController.text),
                        testTwo: int.parse(testOneController.text),
                        midTerm: int.parse(midTermController.text),
                        finalExam: int.parse(finalController.text),
                        assesment: int.parse(assesmentController.text)));
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => TeacherHome()));
                    GoRouter.of(context).pushNamed("teacher homepage");
                  },
                  child: Text("submit"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
