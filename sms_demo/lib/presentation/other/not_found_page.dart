import 'package:flutter/material.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage();

  @override
  _NotFoundPageState createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final RelativeRectTween _relativeRectTween = RelativeRectTween(
    begin: RelativeRect.fromLTRB(24, 24, 24, 200),
    end: RelativeRect.fromLTRB(24, 24, 24, 250),
  );

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xffffff),
      body: Stack(
        children: [
          PositionedTransition(
            rect: _relativeRectTween.animate(_controller),
            child: Container(
              child: Image.asset('assets/heart.png'),
            ),
          ),
          Positioned(
            top: 150,
            bottom: 0,
            left: 24,
            right: 24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                const Text(
                  'Server Error',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50,
                      letterSpacing: 2,
                      color: Colors.white,
                      fontFamily: 'Anton',
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Sorry, we couldn\'t connect to the backend server!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
