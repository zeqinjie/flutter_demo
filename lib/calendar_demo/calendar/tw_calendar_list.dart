/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 22:10:08
 * @LastEditTime: 2022-07-21 16:17:38
 * @Description: your project
 */
library calendar_list;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tw_chart_demo/calendar_demo/calendar/utils/tw_calendart_tool.dart';
import 'package:tw_chart_demo/common/colors/tw_colors.dart';
import 'tw_month_view.dart';
import 'tw_weekday_row.dart';

class TWCalendarList extends StatefulWidget {
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

  TWCalendarList({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    this.headerView,
    this.onSelectFinish,
    this.selectedStartDate,
    this.selectedEndDate,
  })  : assert(!firstDate.isAfter(lastDate),
            'lastDate must be on or after firstDate'),
        super(key: key);

  @override
  _TWCalendarListState createState() => _TWCalendarListState();
}

class _TWCalendarListState extends State<TWCalendarList> {
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

  /// 间隔多少月
  late int count;

  final double weekDayHeight = 48.w;

  final double horizontalPadding = 8.w;

  final double ensureViewHeight = 67.w;

  @override
  void initState() {
    super.initState();
    _configure();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  /* UI Method */
  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          if (widget.headerView != null) widget.headerView!,
          Expanded(
            child: Stack(
              clipBehavior: Clip.hardEdge,
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
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayView() {
    return Container(
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: TWColors.twF5F5F5,
            offset: Offset(0, 1.0),
            blurRadius: 1.0,
          )
        ],
      ),
      child: const TWWeekdayRow(),
    );
  }

  Widget _buildEnsureView() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: 15.w,
        top: 12.w,
        bottom: 12.w,
        right: 15.w,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: TWColors.twF5F5F5,
            offset: Offset(0, -1.0),
            blurRadius: 2.0,
          )
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
                  EdgeInsets.only(
                    top: 12.w,
                    bottom: 12.w,
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                    (selectStartTime != null ||
                            (selectStartTime != null && selectEndTime != null))
                        ? TWColors.twFF8000
                        : TWColors.twB3B3B3),
              ),
              child: Text(
                _getEnsureTitle(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: TWColors.twFFFFFF,
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

  Widget _getMonthView(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    return TWMonthView(
      context: context,
      year: year,
      month: month,
      padding: horizontalPadding,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      selectStartDateTime: selectStartTime,
      selectEndDateTime: selectEndTime,
      todayColor: TWColors.twB3B3B3,
      onSelectDayRang: (dateTime) => _onSelectDayChanged(dateTime),
    );
  }

  /* Private Method */
  void _configure() {
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
    // 总月数
    count = monthEnd - monthStart + (yearEnd - yearStart) * 12 + 1;
  }

  String _getEnsureTitle() {
    String btnTitle = '確   定';
    final selectedDaysTitle =
        TWCalendarTool.getSelectedDaysTitle(selectStartTime, selectEndTime);
    final days = TWCalendarTool.getSelectedDays(selectStartTime, selectEndTime);
    if (days != 0) {
      btnTitle = '確定 ($selectedDaysTitle 共$days天)';
    }
    return btnTitle;
  }

  // 选项处理回调
  void _onSelectDayChanged(DateTime dateTime) {
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

  void _finishSelect() {
    if (selectStartTime != null) {
      widget.onSelectFinish!(selectStartTime, selectEndTime);
    }
  }
}
