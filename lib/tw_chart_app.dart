import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tw_chart_demo/chart/chart_bean.dart';
import 'package:tw_chart_demo/chart/view/chart_line.dart';

///@Description     xxxx
///@author          zhengzeqin
///@create          2021-11-28 11:29 

class TWChartApp extends StatelessWidget {
  const TWChartApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chart Demo',
      debugShowCheckedModeBanner: false,
      home: AnnotatedRegion(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarBrightness: Brightness.dark),
        child: const TWChartDemo(),
      ),
    );
  }
}


class TWChartDemo extends StatelessWidget {
  const TWChartDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        _buildChartCurve(context),
        // _buildChartLine(context),
      ],
    );
  }

  ///curve
  Widget _buildChartCurve(context) {
    var chartLine = ChartLine(
      chartBeans: [
        ChartBean(x: '1月', y: 30.5),
        ChartBean(x: '2月', y: 8.3),
        ChartBean(x: '3月', y: 120),
        ChartBean(x: '4月', y: 67),
        ChartBean(x: '5月', y: 10),
        ChartBean(x: '6月', y: 40),
      ],
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 5 * 1.6),
      isCurve: false,
      lineWidth: 2,
      lineColor: Colors.blueAccent,
      fontColor: Colors.grey,
      xyColor: Colors.white,
      backgroundColor: Colors.yellow,
      isShowYValue: false,
      isShowXy: false,
      isShowXyRuler: false,
      isShowFloat: true,
      shaderColors: [
        Colors.blueAccent.withOpacity(0.3),
        Colors.blueAccent.withOpacity(0.2),
        Colors.blueAccent.withOpacity(0.1),
        Colors.blueAccent.withOpacity(0.0)
      ],
      fontSize: 12,
      yNum: 8,
      isAnimation: true,
      isReverse: false,
      isCanTouch: true,
      isShowPressedHintLine: true,
      pressedPointRadius: 4,
      pressedHintLineWidth: 0.5,
      pressedHintLineColor: Colors.white,
      duration: const Duration(milliseconds: 2000),
    );
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      semanticContainer: true,
      color: Colors.green.withOpacity(0.5),
      child: chartLine,
      clipBehavior: Clip.antiAlias,
    );
  }
}




