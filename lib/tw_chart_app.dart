import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tw_chart_demo/chart/chart_bean.dart';
import 'package:tw_chart_demo/chart/chart_pie_bean.dart';
import 'package:tw_chart_demo/chart/view/chart_bar.dart';
import 'package:tw_chart_demo/chart/view/chart_line.dart';
import 'package:tw_chart_demo/chart/view/chart_pie.dart';

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
        // _buildChartCurve(context),
        // _buildChartLine(context),
        // _buildChartBarCircle(context),
        // _buildChartBarRound(context),
        _buildChartPie(context)
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
        ChartBean(x: '6月', y: 100),
      ],
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 5 * 1.6),
      isCurve: false,
      lineWidth: 2,
      lineColor: Colors.blueAccent,
      fontColor: Colors.grey,
      xyColor: Colors.white,
      backgroundColor: Colors.white,
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

  ///line
  Widget _buildChartLine(context) {
    var chartLine = ChartLine(
      chartBeans: [
        ChartBean(x: '12-01', y: 30),
        ChartBean(x: '12-02', y: 88),
        ChartBean(x: '12-03', y: 20),
        ChartBean(x: '12-04', y: 67),
        ChartBean(x: '12-05', y: 10),
        ChartBean(x: '12-06', y: 40),
        ChartBean(x: '12-07', y: 10),
      ],
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 5 * 1.6),
      isCurve: false,
      lineWidth: 2,
      lineColor: Colors.yellow,
      fontColor: Colors.white,
      xyColor: Colors.white,
      shaderColors: [
        Colors.yellow.withOpacity(0.3),
        Colors.yellow.withOpacity(0.1)
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
      color: Colors.yellow.withOpacity(0.4),
      child: chartLine,
      clipBehavior: Clip.antiAlias,
    );
  }

  ///bar-circle
  Widget _buildChartBarCircle(context) {
    var chartBar = ChartBar(
      chartBeans: [
        ChartBean(x: '12-01', y: 30, color: Colors.red),
        ChartBean(x: '12-02', y: 100, color: Colors.yellow),
        ChartBean(x: '12-03', y: 70, color: Colors.green),
        ChartBean(x: '12-04', y: 70, color: Colors.blue),
        ChartBean(x: '12-05', y: 30, color: Colors.deepPurple),
        ChartBean(x: '12-06', y: 90, color: Colors.deepOrange),
        ChartBean(x: '12-07', y: 50, color: Colors.greenAccent)
      ],
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 5 * 1.8),
      rectColor: Colors.deepPurple,
      isShowX: true,
      fontColor: Colors.white,
      rectShadowColor: Colors.white.withOpacity(0.5),
      isReverse: false,
      isCanTouch: true,
      isShowTouchShadow: true,
      isShowTouchValue: true,
      rectRadiusTopLeft: 50,
      rectRadiusTopRight: 50,
      duration: const Duration(milliseconds: 1000),
    );
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      semanticContainer: true,
      color: Colors.blue.withOpacity(0.4),
      child: chartBar,
      clipBehavior: Clip.antiAlias,
    );
  }

  ///bar-round
  Widget _buildChartBarRound(context) {
    var chartBar = ChartBar(
      chartBeans: [
        ChartBean(x: '12-01', y: 30, color: Colors.red),
        ChartBean(x: '12-02', y: 100, color: Colors.yellow),
        ChartBean(x: '12-03', y: 70, color: Colors.green),
        ChartBean(x: '12-04', y: 70, color: Colors.blue),
        ChartBean(x: '12-05', y: 30, color: Colors.deepPurple),
        ChartBean(x: '12-06', y: 90, color: Colors.deepOrange),
        ChartBean(x: '12-07', y: 50, color: Colors.greenAccent)
      ],
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 5 * 1.8),
      rectColor: Colors.deepPurple,
      isShowX: true,
      fontColor: Colors.white,
      rectShadowColor: Colors.white.withOpacity(0.5),
      isReverse: false,
      isCanTouch: true,
      isShowTouchShadow: true,
      isShowTouchValue: true,
      rectRadiusTopLeft: 4,
      rectRadiusTopRight: 4,
      duration: const Duration(milliseconds: 1000),
    );
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      semanticContainer: true,
      color: Colors.brown.withOpacity(0.6),
      child: chartBar,
      clipBehavior: Clip.antiAlias,
    );
  }

  ///pie
  Widget _buildChartPie(context) {
    var chartPie = ChartPie(
      chartBeans: [
        ChartPieBean(type: '话费', value: 30, color: Colors.blueGrey),
        ChartPieBean(type: '零食', value: 120, color: Colors.deepPurple),
        ChartPieBean(type: '衣服', value: 60, color: Colors.green),
        ChartPieBean(type: '早餐', value: 60, color: Colors.blue),
        ChartPieBean(type: '水果', value: 30, color: Colors.red),
      ],
      size: Size(
          MediaQuery.of(context).size.width, MediaQuery.of(context).size.width),
      R: MediaQuery.of(context).size.width / 3,
      centerR: 6,
      duration: const Duration(milliseconds: 2000),
      centerColor: Colors.white,
      fontColor: Colors.white,
    );
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      color: Colors.orangeAccent.withOpacity(0.6),
      clipBehavior: Clip.antiAlias,
      borderOnForeground: true,
      child: chartPie,
    );
  }
}




