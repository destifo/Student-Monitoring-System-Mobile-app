import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Bloc/ParentAccountManagement/ParAccBloc.dart';
import 'package:sms_demo/Bloc/ParentAccountManagement/ParAccEvent.dart';
import 'package:sms_demo/Bloc/TeacherAccountManagement/TeacherAccBloc.dart';
import 'package:sms_demo/Bloc/TeacherAccountManagement/TeacherAccEvent.dart';
import 'package:sms_demo/Bloc/admin_announcement_Bloc/announcemnt_bloc.dart';
import 'package:sms_demo/Bloc/admin_announcement_Bloc/blocs.dart';
import 'package:sms_demo/Bloc/auth/auth_bloc.dart';
import 'package:sms_demo/Data/Teacher/data_provider/marklist/marklist_remote_provider.dart';
import 'package:sms_demo/Data/Teacher/data_provider/teacher/teacher_user_remote_provider.dart';
import 'package:sms_demo/Data/Teacher/data_repository/marklist_repository.dart';
import 'package:sms_demo/Data/Teacher/data_repository/teacher_user_repository.dart';
import 'package:sms_demo/Data/admin/Announcement/DataProvider/announcemnt_provider.dart';
import 'package:sms_demo/Data/admin/Announcement/Repository/announcemnt_repository.dart';
import 'package:sms_demo/Data/admin/Management/data_provider/parent_provider/parent_api_provider.dart';
import 'package:sms_demo/Data/admin/Management/data_provider/teacher_provider/teacher_api_provider.dart';
import 'package:sms_demo/Data/admin/Management/data_repository/ParentAccRepo/parent_repo.dart';
import 'package:sms_demo/Data/admin/Management/data_repository/TeacherAccRepo/teacher_repo.dart';
import 'package:sms_demo/Data/auth/data_provider/auth_remote_provider.dart';
import 'package:sms_demo/Data/auth/data_repository/auth_repository.dart';
import 'package:sms_demo/Data/local/shared_preferences/shared_preference_service.dart';
import 'package:sms_demo/Domain/model/admin/Announcement/announcemnt_model.dart';
import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';
import 'package:sms_demo/Domain/model/admin/Management/teacher_model.dart';
import 'package:sms_demo/Domain/model/parent/student.dart';
import 'package:sms_demo/presentation/Admin/screens/Announcement/create_announcemnt.dart';
import 'package:sms_demo/presentation/Admin/screens/Announcement/list_announcemnt.dart';
import 'package:sms_demo/presentation/Admin/screens/Grades/Grades.dart';
import 'package:sms_demo/presentation/Admin/screens/Grades/Students_List.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/parent_form.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/smy_home_page.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/teacher_form.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/teacher_page.dart';
import 'package:sms_demo/presentation/Admin/screens/main_dashboard.dart';
import 'package:sms_demo/presentation/Parent/screens/Announcement/list_announcemnt_parent.dart';
import 'package:sms_demo/presentation/Parent/screens/Grades/grade_screen_parent%20.dart';
import 'package:sms_demo/presentation/Parent/screens/parent_dashboard.dart';
import 'package:sms_demo/presentation/auth/login_screen.dart';
import 'package:sms_demo/presentation/other/not_found_page.dart';
import 'package:sms_demo/presentation/teacher/screens/FillMark.dart';
import 'package:sms_demo/presentation/teacher/screens/TeacherHome.dart';
import 'package:sms_demo/themes/app_theme.dart';
import 'package:http/http.dart' as http;
import 'Bloc/marklist_bloc/marklist_bloc.dart';
import 'Bloc/profile_bloc/teacher_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- bloc: ${bloc.runtimeType}');
  }
}

void main() {
  BlocOverrides.runZoned(
    () => runApp(
      MyApp(),
    ),
    blocObserver: SimpleBlocObserver(),
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AuthRepository authRepository =
      AuthRepository(authProvider: AuthRemoteProvider());
  final SharedPreferenceService prefService = SharedPreferenceService();

  final GoRouter _router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
            name: "error page",
            path: '/error',
            pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const NotFoundPage(),
                )),
        GoRoute(
            name: 'teacher homepage',
            path: '/teacherHomepage',
            pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: TeacherHome(),
                ),
            routes: [
              GoRoute(
                name: 'view students',
                path: 'section',
                pageBuilder: (context, state) {
                  String section = state.extra! as String;
                  return MaterialPage(
                    key: state.pageKey,
                    child: FillMark(
                      section: section,
                    ),
                  );
                },
              ),
            ]),
        GoRoute(
          name: 'parent dashboard',
          path: '/parentDashboard',
          pageBuilder: (context, state) { 
            Student student = state.extra! as Student;
            return MaterialPage(
            key: state.pageKey,
            child: ParentDashboard(student: student,),
          );},
          routes: [
            GoRoute(
                name: 'student mark',
                path: 'studentMark/:id',
                pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: GradeScreenParent(),
                    )),
          ],
        ),
        // GoRoute(
        //     path: '/studentMark',
        //     pageBuilder: (context, state) => MaterialPage(
        //           key: state.pageKey,
        //           child: GradeScreenParent(),
        //         )),

        GoRoute(
          name: "parent announcement",
          path: '/parentAnnoucement',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: ListAnnouncemntsParent(),
          ),
        ),
        GoRoute(
          name: 'admin dashboard',
          path: '/adminDashboard',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const MainDashboard(),
          ),
          routes: [
            GoRoute(
              name: "admin announcement",
              path: 'adminAnnoucement',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: ListAnnouncemnts(),
              ),
              routes: [
                GoRoute(
                    name: "create announcement",
                    path: 'createAnnoucement',
                    pageBuilder: (context, state) => MaterialPage(
                          key: state.pageKey,
                          child: CreateAnnouncemnt(),
                        )),
                GoRoute(
                    name: "edit announcement",
                    path: 'editAnnoucement',
                    pageBuilder: (context, state) {
                      final Announcemnt announcement =
                          state.extra! as Announcemnt;
                      return MaterialPage(
                        key: state.pageKey,
                        child: BlocProvider.value(
                            value: BlocProvider.of<AnnouncemntBloc>(context),
                            child: CreateAnnouncemnt(
                              announcemnt: announcement,
                            )),
                      );
                    }),
              ],
            ),
            // GoRoute(
            //   name: "admin home announcement",
            //   path: 'adminHomeAnnoucement',
            //   pageBuilder: (context, state) => MaterialPage(
            //     key: state.pageKey,
            //     child: ListAnnouncemntsParent(),
            //   ),
            //   routes: [

            //   ],
            // ),
            GoRoute(
                name: 'manage teachers',
                path: 'teachers',
                pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: TeacherPage(),
                    ),
                routes: [
                  GoRoute(
                    name: 'add teacher',
                    path: 'add',
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: TeacherForm(
                        status: 1,
                      ),
                    ),
                  ),
                  GoRoute(
                    name: 'edit teacher',
                    path: 'teacher',
                    pageBuilder: (context, state) {
                      TeacherModel teacher = state.extra! as TeacherModel;
                      return MaterialPage(
                        key: state.pageKey,
                        child: TeacherForm(
                          status: 0,
                          teacher: teacher,
                        ),
                      );
                    },
                  ),
                ]),
            GoRoute(
                name: 'manage parents',
                path: 'parents',
                pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: MyHomePage(),
                    ),
                routes: [
                  GoRoute(
                    name: 'add parent',
                    path: 'add',
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: ParentForm(
                        status: 1,
                      ),
                    ),
                  ),
                  GoRoute(
                    name: 'edit parent',
                    path: 'parent',
                    pageBuilder: (context, state) {
                      ParentModel parent = state.extra! as ParentModel;
                      return MaterialPage(
                        key: state.pageKey,
                        child: ParentForm(
                          status: 0,
                          parent: parent,
                        ),
                      );
                    },
                  ),
                ]),
            GoRoute(
                name: 'section list',
                path: 'sectionList/:sectionName',
                pageBuilder: (context, state) {
                  String sectionName = (state.params['sectionName']).toString();
                  return MaterialPage(
                    key: state.pageKey,
                    child: StudentsScreen(sectionName: sectionName),
                  );
                },
                routes: [
                  GoRoute(
                    name: 'view student grade admin',
                    path: 'grade/:studentid',
                    pageBuilder: (context, state) {
                      String? studentid = state.params['studentid'];
                      return MaterialPage(
                        key: state.pageKey,
                        child: GradeScreen(),
                      );
                    },
                  )
                ]),
          ],
        ),

        GoRoute(
          name: 'log in',
          path: '/login',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: LoginScreen(),
          ),
        ),
      ],
      errorPageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: Scaffold(
              body: Center(
                child: Text(
                  state.error.toString(),
                ),
              ),
            ),
          ));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final currTheme = AppTheme.dark();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Teacher_bloc(TeacherUserRepository(
              teacherProvider:
                  TeacherUserRemoteProvider()))
            ..add(LoadTeacher()),
        ),
        BlocProvider(
          create: (context) =>
              MarklistBloc(MarklistRepository(MarklistRemoteProvider())),
        ),
        BlocProvider(create: (ctx) => AuthBloc(authRepository)),
        BlocProvider<ParAccBloc>(
          create: (context) =>
              ParAccBloc(ParentRepository(parentProvider: ParentApiProvider()))
                ..add(LoadParAccs()),
        ),
        BlocProvider(
          create: (context) => TeacherAccBloc(
            TeacherRepository(teacherProvider: TeacherApiProvider()),
          )..add(LoadTeacherAccs()),
        ),
        BlocProvider<AnnouncemntBloc>(
            create: (context) => AnnouncemntBloc(
                    announcemntRepository: AnnouncemntRepository(
                        dataProvider: AnnouncemntDataProvider(
                  httpClient: http.Client(),
                )))
                  ..add(AnnouncemntLoad())),
      ],
      child: MaterialApp.router(
        theme: currTheme,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: "What is title",
      ),
    );
  }
}
