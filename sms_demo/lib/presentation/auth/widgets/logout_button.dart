import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Data/local/shared_preferences/shared_preference_service.dart';

class LogoutButton extends StatelessWidget {
  final SharedPreferenceService prefService = SharedPreferenceService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: IconButton(
        icon: const Icon(Icons.logout ,color: Colors.white,
        ),
        onPressed: () async {
          prefService.removeToken();
          Future.delayed(const Duration(seconds: 2));
          GoRouter.of(context).goNamed('log in');
        },
      ),
    );
  }
}
