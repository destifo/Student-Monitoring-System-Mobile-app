import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sms_demo/Data/auth/data_provider/auth_provider.dart';
import 'package:sms_demo/Data/auth/data_repository/auth_repository.dart';
import 'package:sms_demo/Domain/model/auth/user.dart';
import 'user_repo_test.mocks.dart';

@GenerateMocks([],
    customMocks: [MockSpec<AuthProvider>(as: #MockUserRepository)])
void main() {
  late MockUserRepository mockUserRepository;
  late AuthRepository userRepository;
  setUp(() {
    mockUserRepository = MockUserRepository();
    userRepository = AuthRepository(authProvider: mockUserRepository);
  });

  final user = User(username: 'Ayele', password: 'Ayele1234');
  test("if user is created", () async {
    //arrange
    when(mockUserRepository.createUser(user)).thenAnswer((_) async => user);
    //act
    final obtain = await userRepository.getUserInfo(user);
    //assert
    expect(obtain, user);
  });

  test("if user is not created", () async {
    //arrange
    when(mockUserRepository.createUser(user)).thenAnswer((_) async => null);
    //act
    final obtain = await userRepository.createUser(user);
    //assert
    expect(obtain, null);
  });

  final user2 = User(username: "man", password: "kinfe11c12c");
  List<User> temp = [user, user2];
  test("if it return list of users in the system", () async {
    //arrange
    when(mockUserRepository.getUserInfo()).thenAnswer((_) async => temp);

    //act
    final obtain = await userRepository.getUserInfo(user);

    //assert
    expect(obtain, temp);
  });

  test("if it failed to return list of users in the system", () {
    //arrange
    when(mockUserRepository.getUsers())
        .thenAnswer((_) async => throw Exception('Failed to load courses'));

    //act
    final obtain = userRepository.getUserInfo(user);

    //assert
    expect(obtain, throwsException);
  });
}
