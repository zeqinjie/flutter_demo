import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tw_chart_demo/sliver_demo/tw_custom_scroll_view.dart';
import 'package:tw_chart_demo/sliver_demo/tw_nested_scroll_view.dart';

/// create by:  zhengzeqin
/// create time:  2022-03-26 11:05
/// des: https://www.bilibili.com/video/BV1RK4y1R74t/?spm_id_from=pageDriver
/// Sliver

class TWSliverApp extends StatefulWidget {
  const TWSliverApp({Key? key}) : super(key: key);

  @override
  State<TWSliverApp> createState() => _TWSliverAppState();
}

class _TWSliverAppState extends State<TWSliverApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('sliver demo')),
        body: const TWCustomScrollView(),  // TWCustomScrollView()
      ),
    );
  }


}
