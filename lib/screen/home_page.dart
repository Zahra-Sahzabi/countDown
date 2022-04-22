// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:countdown/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController controller;

  bool isPlaying = false;

  double progress = 1.0;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${(controller.duration!.inHours)} : ${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')} : ${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')} '
        : '${(count.inHours).toString()} : ${(count.inMinutes % 60).toString().padLeft(2, '0')} : ${(count.inSeconds % 60).toString().padLeft(2, '0')}';
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

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          isPlaying = false;
          progress = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void notify() {
    if (countText == '0 : 00 : 00') {
      FlutterRingtonePlayer.playNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5fbff),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 6,
                  ),
                ),
                GestureDetector(
                  onTap: (() {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: 300,
                        child: CupertinoTimerPicker(
                          initialTimerDuration: controller.duration!,
                          onTimerDurationChanged: (time) {
                            setState(() {
                              controller.duration = time;
                            });
                          },
                        ),
                      ),
                    );
                  }),
                  child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return Text(
                          countText,
                          style: TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold),
                        );
                      }),
                ),
              ],
            ),
          ),
          // ignore: prefer_const_literals_to_create_immutables
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      if (controller.isAnimating) {
                        controller.stop();
                        setState(() {
                          isPlaying = false;
                        });
                      } else {
                        controller.reverse(
                            from:
                                controller.value == 0 ? 1.0 : controller.value);
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                    child: Button(
                        icon: isPlaying == true
                            ? Icons.pause
                            : Icons.play_arrow)),
                GestureDetector(
                    onTap: () {
                      controller.reset();
                      setState(() {
                        isPlaying = false;
                      });
                    },
                    child: Button(icon: Icons.stop))
              ],
            ),
          )
        ],
      ),
    );
  }
}
