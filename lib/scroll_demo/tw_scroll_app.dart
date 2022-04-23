import 'package:flutter/material.dart';
import 'dart:math';

/// create by:  zhengzeqin
/// create time:  2022-04-23 13:18
/// des: 滚动

class TWScrollApp extends StatefulWidget {
  const TWScrollApp({Key? key}) : super(key: key);

  @override
  State<TWScrollApp> createState() => _TWScrollAppState();
}

class _TWScrollAppState extends State<TWScrollApp> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("滚动"),
        ),
        body: _gridView(),
      ),
    );
  }

  Widget _buildListView() {
    return Scrollbar(
      controller: _controller,
      child: NotificationListener(
        onNotification: (_event) {
          // print(_event);
          return true; // 如果返回 TRUE 就止住事件冒泡，上层的就监听不到
        },
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
          },
          strokeWidth: 4.0,
          color: Colors.orange,
          child: ListView.builder(
            itemCount: 200,
            controller: _controller,
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  color: Colors.green,
                  child: const Icon(
                    Icons.phone,
                    size: 24,
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.yellow,
                ),
                confirmDismiss: (dir) async {
                  // 是否删除
                  return true;
                },
                dismissThresholds: const {
                  // 滑动百分比比例后执行
                  DismissDirection.startToEnd: 0.1,
                  DismissDirection.endToStart: 0.9,
                },
                resizeDuration: const Duration(seconds: 4),
                movementDuration: const Duration(seconds: 4),
                onDismissed: (dir) {
                  // print('方向:$dir');
                  if (dir == DismissDirection.startToEnd) {
                    print('call...');
                  }
                },
                key: UniqueKey(),
                child: Container(
                  height: 50,
                  color: index % 2 == 0 ? Colors.blue : Colors.red,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _gridView() {
    return GridView.builder(
      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 4,
      // ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 16/9,
        maxCrossAxisExtent: 100,
      ),
      itemBuilder: (_, index) {
        return Container(
          color: getRandomColor(),
          alignment: Alignment.center,
          child: Text('$index'),
        );
      },
    );
  }

  Widget _buildListWheelScrollView() {
    return RotatedBox(
      quarterTurns: 1,
      child: ListWheelScrollView(
        itemExtent: 100,
        // offAxisFraction: -1.5,
        // diameterRatio: 0.8,
        // useMagnifier: true,
        children: List.generate(
          10,
          (index) => Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: -1,
              child: Text('$index'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      pageSnapping: true,
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        print('index === $index');
      },
      children: [
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildReorderableListView() {
    return ReorderableListView(
      children: List.generate(
        10,
        (index) {
          return Text(
            'index: $index',
            key: UniqueKey(),
          );
        },
      ),
      header: Text('header...'),
      onReorder: (oldIndex, newIndex) {
        print('old - new: $oldIndex, $newIndex');
      },
    );
  }

  Widget _buildScrollView() {
    return SingleChildScrollView(
      child: Column(
        children: const [
          FlutterLogo(
            size: 300,
          ),
          FlutterLogo(
            size: 800,
          ),
        ],
      ),
    );
  }

  Color getRandomColor({int r = 255, int g = 255, int b = 255, a = 255}) {
    if (r == 0 || g == 0 || b == 0) return Colors.black;
    if (a == 0) return Colors.white;
    return Color.fromARGB(
      a,
      r != 255 ? r : Random.secure().nextInt(r),
      g != 255 ? g : Random.secure().nextInt(g),
      b != 255 ? b : Random.secure().nextInt(b),
    );
  }
}
