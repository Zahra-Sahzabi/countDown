// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController controller;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return '${count.inSeconds}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
          seconds: 60 // will be our countdown timer starting duration),
          ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5fbff),
      body: Column(
        children: [
          Expanded(
            child: Stack(alignment: Alignment.center, children: [
              Text(
                countText,
                style: TextStyle(fontSize: 60),
              ),
            ]),
          ),
          // ignore: prefer_const_literals_to_create_immutables
          Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: null, child: null),
                SizedBox(width: 30,),
                ElevatedButton(onPressed: null, child: null)
              ],
            ),
          )
        ],
      ),
    );
  }
}
