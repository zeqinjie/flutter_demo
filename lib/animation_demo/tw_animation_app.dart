import 'package:flutter/material.dart';
import 'package:tw_chart_demo/animation_demo/tw_animation_display_view.dart';
import 'package:tw_chart_demo/animation_demo/tw_animation_implicit_view.dart';
import 'package:tw_chart_demo/animation_demo/tw_animation_view.dart';

/// create by:  zhengzeqin
/// create time:  2022-03-15 22:37
/// des: 隐式动画

class TWAnimationApp extends StatefulWidget {
  const TWAnimationApp({Key? key}) : super(key: key);

  @override
  State<TWAnimationApp> createState() => _TWAnimationAppState();
}

class _TWAnimationAppState extends State<TWAnimationApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: const TWAnimationView(),
      ),
    );
  }


}


