// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: CircleAvatar(
        radius: 30,
        child: Icon(
          icon,
          size: 36,
        ),
      ),
    );
  }
}
