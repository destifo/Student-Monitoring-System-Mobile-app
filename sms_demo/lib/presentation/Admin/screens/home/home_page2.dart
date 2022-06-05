import 'package:flutter/material.dart';

class HomePage2 extends StatelessWidget {
  final String title;
  final String body;
  const HomePage2({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(body),
      ),
    );
  }
}
