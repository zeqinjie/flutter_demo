import 'package:flutter/material.dart';

/// create by:  zhengzeqin
/// create time:  2022-03-15 22:37 
/// des: 动画


class TWAnimationApp extends StatelessWidget {
  const TWAnimationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '动画 Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("动画 demo"),
        ),
        body: Center(
          child: Container(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

}
