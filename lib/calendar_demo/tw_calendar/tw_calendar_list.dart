/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 22:10:08
 * @LastEditTime: 2022-07-23 16:56:07
 * @Description: 日历组件
 */
library calendar_list;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tw_chart_demo/common/colors/tw_colors.dart';
import 'tw_month_view.dart';
import 'tw_weekday_row.dart';
import 'utils/tw_calendart_tool.dart';

enum TWCalendarListSeletedMode {
  /// 默认选择是连续多选
  defaltSerial,

  /// 单选连续,从可选日开始
  singleSerial,
}

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

  /// 月视图高度
  final double? monthBodyHeight;

  /// 选择模式
  final TWCalendarListSeletedMode? seletedMode;

  /// 点击回调
  final void Function(DateTime seletedDate, int seletedDays)? onSelectDayRang;

  TWCalendarList({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    this.headerView,
    this.onSelectFinish,
    this.selectedStartDate,
    this.selectedEndDate,
    this.monthBodyHeight = 300,
    this.onSelectDayRang,
    this.seletedMode = TWCalendarListSeletedMode.defaltSerial,
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

  /// 周视图高度
  final double weekDayHeight = 48.w;

  /// 水平间隙
  final double horizontalPadding = 8.w;

  final double ensureViewHeight = 67.w;

  /// 选中了多少天
  int seletedDays = 0;

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
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.headerView != null) widget.headerView!,
          SizedBox(
            height: weekDayHeight,
            child: _buildWeekdayView(),
          ),
          SizedBox(
            height: widget.monthBodyHeight,
            child: _buildMonthView(),
          ),
          SizedBox(
            height: ensureViewHeight,
            child: _buildEnsureView(),
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
        color: TWColors.twFFFFFF,
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
        color: TWColors.twFFFFFF,
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
      color: TWColors.twFFFFFF,
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

    seletedDays =
        TWCalendarTool.getSelectedDays(selectStartTime, selectEndTime);
  }

  String _getEnsureTitle() {
    String btnTitle = '確   定';
    final selectedDaysTitle =
        TWCalendarTool.getSelectedDaysTitle(selectStartTime, selectEndTime);
    if (seletedDays != 0) {
      btnTitle = '確定 ($selectedDaysTitle 共$seletedDays)';
    }
    return btnTitle;
  }

  // 选项处理回调
  void _onSelectDayChanged(DateTime dateTime) {
    switch (widget.seletedMode) {
      case TWCalendarListSeletedMode.singleSerial:
        selectStartTime = widget.firstDate.add(const Duration(days: 1));
        selectEndTime = dateTime;
        break;
      default:
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
            seletedDays = 0;
            _handerSelectDayRang(dateTime);
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
    }
    seletedDays =
        TWCalendarTool.getSelectedDays(selectStartTime, selectEndTime);
    _handerSelectDayRang(dateTime);
    setState(() {
      selectStartTime;
      selectEndTime;
    });
  }

  void _handerSelectDayRang(DateTime dateTime) {
    if (widget.onSelectDayRang != null) {
      widget.onSelectDayRang!(dateTime, seletedDays);
    }
  }

  void _finishSelect() {
    if (selectStartTime != null) {
      widget.onSelectFinish!(selectStartTime, selectEndTime);
    }
  }
}
