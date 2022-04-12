import 'package:flutter/material.dart';

/// create by:  zhengzeqin
/// create time:  2022-04-07 22:06
/// des: 布局探索
/// https://flutter.cn/docs/development/ui/layout/constraints
/// https://www.bilibili.com/video/BV1254y1s7Zo?spm_id_from=333.999.0.0

class TWLayoutApp extends StatelessWidget {
  const TWLayoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    // return _buildLogo1();

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("布局探索"),
        ),
        body: _buildCustomMultiChildLayout2(),
      ),
    );
  }

  /// 流程案例
  /// ● 首先，上层 widget 向下层 widget 传递约束条件；
  /// ● 然后，下层 widget 向上层 widget 传递大小信息。
  /// ● 最后，上层 widget 决定下层 widget 的位置。
  Widget _buildLogo1() {
    return Container(
      color: Colors.red,
      width: 0.04,
      height: 0.0008,
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.white,
          child: const FlutterLogo(
            size: 11,
          ),
        ),
      ),
    );
  }

  /// 如果想打破这紧约束，可以给 FlutterLogo 添加 Center 父 widget
  Widget _buildLogo2() {
    return Container(
      color: Colors.red,
      width: 0.04,
      height: 0.0008,
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.white,
          child: const Center(
            child: FlutterLogo(
              size: 11,
            ),
          ),
        ),
      ),
    );
  }

  /// LayoutBuilder
  /// 打印信息： flutter: BoxConstraints(0.0<=w<=200.0, 0.0<=h<=200.0)
  Widget _buildLogo3() {
    return Container(
      color: Colors.red,
      width: 0.04,
      height: 0.0008,
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.white,
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                print(constraints);
                return const FlutterLogo(
                  size: 11,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Column当crossAxisAlignment为CrossAxisAlignment.stretch
  /// 时候组件会在纵轴调整为紧约束，宽度占满父 widget
  Widget _buildLogo4() {
    return Center(
      child: Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed: null, child: Text("xxx")),
            ElevatedButton(onPressed: null, child: Text("xxx")),
            LayoutBuilder(
              builder: (context, constraints) {
                print(constraints);
                return FlutterLogo(
                  size: 100,
                );
              },
            ),
            ListView(),
            FlutterLogo(
              size: 200,
            ),
            FlutterLogo(
              size: 50,
            ),
          ],
        ),
      ),
    );
  }

  /// Stack 布局大小
  Widget _buildStack() {
    return Container(
      color: Colors.blue,
      constraints: BoxConstraints(
        minWidth: 20,
        maxWidth: 300,
        minHeight: 20,
        maxHeight: 500,
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        fit: StackFit.passthrough,
        children: [
          // Positioned(
          //   right: -10,
          //   child: Container(
          //     color: Colors.yellow,
          //     child: Text(
          //       "zhengzeqin",
          //       style: TextStyle(fontSize: 20),
          //     ),
          //   ),
          // ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              color: Colors.green,
              child: Text(
                "0",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Transform.translate(
              offset: Offset(50, 0),
              child: FlutterLogo(
                size: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 加了 Align 的组件，那他就占满父组件的大小，否则就是 child 组件的大小
  Widget _buildContainer1() {
    return Container(
      color: Colors.orange,
      alignment: Alignment.center,
      child: const FlutterLogo(
        size: 100,
      ),
    );
  }

  /// 没 child 越大越好，除非无边界
  /// 当 Column 无边界（unbounded）包裹，那么就高度为 0
  Widget _buildContainer2() {
    return Column(
      children: [
        Container(
          color: Colors.orange,
        ),
      ],
    );
  }

  /// 当无边界，且有 child 时则匹配 child 高度
  Widget _buildContainer3() {
    return Column(
      children: [
        Container(
          color: Colors.orange,
          alignment: Alignment.center,
          child: const FlutterLogo(
            size: 100,
          ),
        ),
      ],
    );
  }

  /// LimitedBox 在无边界组件（Row、Column）才生效
  /// 当在 Column（高度无边界），那么最大是 LimitedBox 的限制高度
  Widget _buildContainer4() {
    return Column(
      children: [
        LimitedBox(
          maxHeight: 10,
          child: Container(
            color: Colors.orange,
            alignment: Alignment.center,
            child: const FlutterLogo(
              size: 200,
            ),
          ),
        ),
      ],
    );
  }

  /// 自定义 Layout
  Widget _buildCustomMultiChildLayout1() {
    return CustomMultiChildLayout(
      delegate: ZQLogoDelegate(),
      children: [
        LayoutId(
          id: 1,
          child: const FlutterLogo(
            size: 50,
          ),
        ),
        LayoutId(
          id: 2,
          child: const FlutterLogo(
            size: 200,
          ),
        ),
      ],
    );
  }

  /// 自定义 下划线文本 Layout
  Widget _buildCustomMultiChildLayout2() {
    return CustomMultiChildLayout(
      delegate: ZQUnderLineTextDelegate(),
      children: [
        LayoutId(
          id: 'underline',
          child: Container(
            color: Colors.red,
          ),
        ),
        LayoutId(
          id: 'text',
          child: const Text(
            'hello world',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class ZQLogoDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    Size size1 = Size.zero;
    if (hasChild(1)) {
      // 向下传递约束，向上传递尺寸
      size1 = layoutChild(
        1,
        BoxConstraints.loose(
          const Size(500, 500),
        ),
      );
      // 设置位置
      positionChild(1, Offset.zero);
    }

    if (hasChild(2)) {
      layoutChild(
        2,
        BoxConstraints.loose(
          const Size(500, 500),
        ),
      );
      positionChild(2, Offset(size1.width, size1.height));
    }
  }

  /// 类似 动画 & 绘图代理，是否需要重绘
  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => true;
}

/// 实现自定义布局代理
class ZQUnderLineTextDelegate extends MultiChildLayoutDelegate {
  final double thickness;

  ZQUnderLineTextDelegate({this.thickness = 2.0});

  @override
  void performLayout(Size size) {
    if (hasChild('text') && hasChild('underline')) {
      // 向下传递约束，向上传递尺寸
      Size textSize = layoutChild(
        'text', // 组件的 ID 唯一
        BoxConstraints.loose(size),
      );
      layoutChild(
        'underline',
        BoxConstraints.tight(Size(textSize.width, thickness)),
      );
      final left = (size.width - textSize.width) / 2;
      final top = (size.height - textSize.height) / 2;
      // 设置位置
      positionChild('text', Offset(left, top));
      positionChild('underline', Offset(left, top + textSize.height));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => true;
}
