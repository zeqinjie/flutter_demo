/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:27:01
 * @LastEditTime: 2022-07-21 09:47:33
 * @Description: 日历组件
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tw_chart_demo/calendar_demo/fullscreen_demo.dart';

class TWCalendarApp extends StatefulWidget {
  const TWCalendarApp({Key? key}) : super(key: key);

  @override
  State<TWCalendarApp> createState() => _TWCalendarAppAppState();
}

class _TWCalendarAppAppState extends State<TWCalendarApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('日历 demo'),
        ),
        body: const _HomePage(),
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  List<DateTime> selectResult1 = <DateTime>[];
  List<DateTime> selectResult2 = <DateTime>[];

  // 全屏方式
  _showNavigateFullScreen(BuildContext context) async {
    selectResult1 = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TWCalendarView()),
    );
  }

  // Dialog方式
  _showNavigateDailog(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return const TWCalendarView();
      },
    ).then((result) {
      setState(() {
        selectResult2 = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            child: const Text('全屏日历'),
            onPressed: () {
              _showNavigateFullScreen(context);
            },
          ),
          Text(
            selectResult1.toString(),
          ),
          TextButton(
            child: const Text('弹出框日历'),
            onPressed: () {
              _showNavigateDailog(context);
            },
          ),
          Text(
            selectResult2.toString(),
          ),
        ],
      ),
    );
  }
}
