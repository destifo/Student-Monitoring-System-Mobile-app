import 'package:flutter/material.dart';

class cardTile extends StatelessWidget {
  cardTile({this.title, this.tap, this.trailing});
  Widget? title;
  Widget? trailing;
  VoidCallback? tap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: title,
        trailing: GestureDetector(child: trailing, onTap: tap),
      ),
    );
  }
}
