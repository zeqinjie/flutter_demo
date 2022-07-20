/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 22:10:08
 * @LastEditTime: 2022-07-20 23:03:45
 * @Description: your project
 */
library calendar_list;

import 'package:flutter/material.dart';

import 'month_view.dart';
import 'weekday_row.dart';

enum CalendarListShowMode {
  dailog,
  fullScreen,
}

class CalendarList extends StatefulWidget {
  /// 开始的年月份
  final DateTime firstDate;

  /// 结束的年月份
  final DateTime lastDate;

  /// 选择开始日期
  final DateTime? selectedStartDate;

  /// 选择结束日期
  final DateTime? selectedEndDate;

  /// 点击方法回调
  final Function? onSelectFinish;

  /// 头部组件
  final Widget? headerView;

  /// 展示模式
  final CalendarListShowMode showMode;

  CalendarList({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    this.headerView,
    this.onSelectFinish,
    this.selectedStartDate,
    this.selectedEndDate,
    this.showMode = CalendarListShowMode.dailog,
  })  : assert(!firstDate.isAfter(lastDate),
            'lastDate must be on or after firstDate'),
        super(key: key);

  @override
  _CalendarListState createState() => _CalendarListState();
}

class _CalendarListState extends State<CalendarList> {
  // ignore: non_constant_identifier_names
  final double HORIZONTAL_PADDING = 8.0;
  late DateTime? selectStartTime;
  late DateTime? selectEndTime;

  /// 开始年份
  late int yearStart;

  /// 结束年份
  late int yearEnd;

  /// 开始月份
  late int monthStart;

  /// 结束月份
  late int monthEnd;

  /// 开始日
  late int dayStart;

  /// 结束日
  late int dayEnd;

  /// 间隔多少天
  late int count;

  double weekDayHeight = 48;

  double ensureViewHeight = 100;

  @override
  void initState() {
    super.initState();
    // 传入的选择开始日期
    selectStartTime = widget.selectedStartDate;
    // 传入的选择结束日期
    selectEndTime = widget.selectedEndDate;
    // 开始年份
    yearStart = widget.firstDate.year;
    // 结束年份
    yearEnd = widget.lastDate.year;
    // 开始月份
    monthStart = widget.firstDate.month;
    // 结束月份
    monthEnd = widget.lastDate.month;
    // 可以选择的开始日
    dayStart = widget.firstDate.day;
    // 可以选择的结束日
    dayEnd = widget.lastDate.day;
    // 总天数
    count = monthEnd - monthStart + (yearEnd - yearStart) * 12 + 1;
  }

  // 选项处理回调
  void onSelectDayChanged(DateTime dateTime) {
    if (selectStartTime == null && selectEndTime == null) {
      selectStartTime = dateTime;
    } else if (selectStartTime != null && selectEndTime == null) {
      selectEndTime = dateTime;
      // 如果选择的开始日期和结束日期相等，则清除选项
      if (selectStartTime == selectEndTime) {
        setState(() {
          selectStartTime = null;
          selectEndTime = null;
        });
        return;
      }
      // 如果用户反选，则交换开始和结束日期
      if (selectStartTime!.isAfter(selectEndTime!)) {
        DateTime temp = selectStartTime!;
        selectStartTime = selectEndTime;
        selectEndTime = temp;
      }
    } else if (selectStartTime != null && selectEndTime != null) {
      selectStartTime = null;
      selectEndTime = null;
      selectStartTime = dateTime;
    }
    setState(() {
      selectStartTime;
      selectEndTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  SafeArea _buildBody() {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: weekDayHeight,
            child: _buildWeekdayView(),
          ),
          _buildMonthView(),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            height: ensureViewHeight,
            child: _buildEnsureView(),
          )
        ],
      ),
    );
  }

  Widget _buildWeekdayView() {
    return Container(
      padding: EdgeInsets.only(
        left: HORIZONTAL_PADDING,
        right: HORIZONTAL_PADDING,
      ),
      decoration: const BoxDecoration(
        // border: Border.all(width: 3, color: Color(0xffaaaaaa)),
        // 实现阴影效果
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2.0),
            blurRadius: 1.0,
          )
        ],
      ),
      child: const WeekdayRow(),
    );
  }

  Widget _buildEnsureView() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 15.0,
        bottom: 32.0,
        right: 15.0,
      ),
      decoration: const BoxDecoration(
        // border: Border.all(width: 3, color: Color(0xffaaaaaa)),
        // 实现阴影效果
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12, offset: Offset(0, -4.0), blurRadius: 4.0)
        ],
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: _finishSelect,
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    color: Colors.white,
                  ),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.only(
                    top: 15.0,
                    bottom: 15.0,
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                    (selectStartTime != null ||
                            (selectStartTime != null && selectEndTime != null))
                        ? Colors.deepOrange
                        : Colors.grey),
              ),
              child: const DefaultTextStyle(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                child: Text(
                  '确  定',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthView() {
    return Container(
      margin: EdgeInsets.only(
        top: weekDayHeight,
        bottom: ensureViewHeight,
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                int month = index + monthStart;
                DateTime calendarDateTime = DateTime(yearStart, month);
                return _getMonthView(calendarDateTime);
              },
              childCount: count,
            ),
          ),
        ],
      ),
    );
  }

  void _finishSelect() {
    if (selectStartTime != null) {
      widget.onSelectFinish!(selectStartTime, selectEndTime);
    }
  }

  Widget _getMonthView(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    return MonthView(
      context: context,
      year: year,
      month: month,
      padding: HORIZONTAL_PADDING,
      dateTimeStart: selectStartTime,
      dateTimeEnd: selectEndTime,
      todayColor: Colors.grey,
      onSelectDayRang: (dateTime) => onSelectDayChanged(dateTime),
    );
  }
}
