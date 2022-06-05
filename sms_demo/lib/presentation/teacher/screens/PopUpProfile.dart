// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:yoseph/teacher/model/teacher.dart';
// import 'package:yoseph/teacher/ui/screens/TeacherHome.dart';

// import '../../bloc/profile_bloc/teacher_bloc.dart';

// class PopUpProfile extends StatelessWidget {
//   final TeacherModel teacher;
//   PopUpProfile({Key? key, required this.teacher}) : super(key: key) {
//     nameController.text = teacher.name;
//     genderController.text = teacher.gender;
//     subjectsController.text = teacher.subjectName;
//     usernameController.text = teacher.username;
//     sectionsController = teacher.sections.map((e) => e.toString()).toList();
//   }
//   final formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final genderController = TextEditingController();
//   final passwordController = TextEditingController();
//   final usernameController = TextEditingController();
//   final subjectsController = TextEditingController();
//   late List<String> sectionsController;

//   // @override
//   // void initState() {
//   //   BlocListener<Teacher_bloc, Teacher_state>(
//   //     listener: (context, state) {
//   //       if (state is Idle) {
//   //         print("in idle");
//   //         print(state.teacher.name);
//   //         nameController.text = state.teacher.name;
//   //         genderController.text = state.teacher.gender;
//   //         subjectsController.text = state.teacher.subjectName;
//   //         usernameController.text = state.teacher.username;
//   //         sectionsController =
//   //             state.teacher.sections.map((e) => e.toString()).toList();
//   //       }
//   //     },
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             TextFormField(
//               controller: nameController,
//               keyboardType: TextInputType.name,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Color.fromARGB(255, 84, 81, 71),
//               ),
//               decoration: const InputDecoration(
//                 hintText: 'Enter your name here ',
//                 prefixIcon: Icon(
//                   Icons.person,
//                   size: 25,
//                 ),
//                 prefixText: 'Edit name: ',
//                 focusColor: Color.fromARGB(255, 84, 81, 71),
//               ),
//               validator: (String? name) {
//                 if (name == null || name.isEmpty) {
//                   return "Name field must not be empty";
//                 }

//                 final validName = RegExp("[A-Za-z]");
//                 final correct = validName.hasMatch(name);

//                 return correct ? null : "Enter a valid name";
//               },
//             ),
//             TextFormField(
//               controller: genderController,
//               keyboardType: TextInputType.text,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Color.fromARGB(255, 84, 81, 71),
//               ),
//               decoration: const InputDecoration(
//                 hintText: 'Enter gender here ',
//                 prefixIcon: Icon(
//                   Icons.female,
//                   size: 25,
//                 ),
//                 prefixText: 'Gender: ',
//                 focusColor: Color.fromARGB(255, 84, 81, 71),
//               ),
//               validator: (String? gender) {
//                 if (gender == null || gender.isEmpty) {
//                   return "Gender must not be empty";
//                 }

//                 final validGender = ['male', 'female'];
//                 final correct = validGender.contains(gender);

//                 return correct
//                     ? null
//                     : "Enter a valid gender ( 'M' (male) or 'F' (female))";
//               },
//             ),

//             TextFormField(
//               controller: passwordController,
//               keyboardType: TextInputType.text,
//               textAlign: TextAlign.center,
//               obscureText: true,
//               style: const TextStyle(
//                 color: Color.fromARGB(255, 84, 81, 71),
//               ),
//               decoration: const InputDecoration(
//                 hintText: 'Enter password here',
//                 prefixIcon: Icon(
//                   Icons.key,
//                   size: 25,
//                 ),
//                 prefixText: 'password: ',
//                 focusColor: Color.fromARGB(255, 84, 81, 71),
//               ),
//               validator: (String? password) {
//                 if (password == null || password.isEmpty) {
//                   return "password must not be empty";
//                 }

//                 if (password.length < 4) {
//                   return "password too short!! ";
//                 }

//                 return null;
//               },
//             ),

// // entering the blog consumer here
//             BlocConsumer<Teacher_bloc, Teacher_state>(
//               listenWhen: ((previous, current) => current is Idle),
//               builder: (_, Teacher_state state) {
//                 Widget result = Text('Edit');
//                 if (state is IdleLoading) {
//                   result = SizedBox(
//                     height: 10,
//                     width: 10,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                     ),
//                   );
//                 }

//                 if (state is Idle) {}

//                 if (state is IdleFailure) {
//                   result = Text("Login Failed");
//                 }
//                 return ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                         const Color.fromARGB(255, 106, 104, 99)),
//                   ),
//                   onPressed: () {
//                     final formValid = formKey.currentState!.validate();
//                     if (!formValid) return;

//                     final teacherBloc = BlocProvider.of<Teacher_bloc>(context);
//                     teacherBloc.add(Edit(
//                         name: nameController.text,
//                         gender: genderController.text,
//                         subject: subjectsController.text,
//                         password: passwordController.text,
//                         sections: sectionsController,
//                         username: usernameController.text));
//                   },
//                   child: result,
//                 );
//               },
//               listener: (_, Teacher_state state) {
//                 // change it by go router
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => TeacherHome(),
//                   ),
//                 );
//               },
//             ),

//             // ),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
