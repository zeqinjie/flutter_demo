import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'calendar_notification.dart';
import 'day_number.dart';
import 'month_title.dart';
import 'utils/tw_calendart_tool.dart';

class MonthView extends StatefulWidget {
  const MonthView({
    Key? key,
    required this.context,
    required this.year,
    required this.month,
    required this.padding,
    required this.selectStartDateTime,
    required this.selectEndDateTime,
    required this.onSelectDayRang,
    required this.firstDate,
    required this.lastDate,
    this.todayColor,
    this.monthNames,
  }) : super(key: key);

  final BuildContext context;
  final int year;
  final int month;
  final double padding;
  final Color? todayColor;
  final List<String>? monthNames;
  final DateTime? selectStartDateTime;
  final DateTime? selectEndDateTime;

  /// 开始的年月份
  final DateTime firstDate;

  /// 结束的年月份
  final DateTime lastDate;

  final Function onSelectDayRang;

  double get itemWidth => TWCalendarTool.getDayNumberSize(context, padding);

  @override
  _MonthViewState createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildMonthView(context),
    );
  }

  Widget buildMonthDays(BuildContext context) {
    List<Row> dayRows = <Row>[];
    List<DayNumber> dayRowChildren = <DayNumber>[];

    int daysInMonth = TWCalendarTool.getDaysInMonth(
      widget.year,
      widget.month,
    );

    // 日 一 二 三 四 五 六
    int firstWeekdayOfMonth = DateTime(widget.year, widget.month, 2).weekday;

    for (int day = 2 - firstWeekdayOfMonth; day <= daysInMonth; day++) {
      DateTime moment = DateTime(widget.year, widget.month, day);
      final bool isToday = TWCalendarTool.dateIsToday(moment);
      final _canSelected = canSelectedDate(date: moment, isToday: isToday);
      bool isDefaultSelected = false;
      if (widget.selectStartDateTime == null &&
          widget.selectEndDateTime == null &&
          selectedDate == null) {
        isDefaultSelected = false;
      }
      if (widget.selectStartDateTime == selectedDate &&
          widget.selectEndDateTime == null &&
          selectedDate?.day == day &&
          day > 0) {
        isDefaultSelected = true;
      }
      if (widget.selectStartDateTime != null &&
          widget.selectEndDateTime != null) {
        isDefaultSelected =
            (moment.isAtSameMomentAs(widget.selectStartDateTime!) ||
                        moment.isAtSameMomentAs(widget.selectEndDateTime!)) ||
                    moment.isAfter(widget.selectStartDateTime!) &&
                        moment.isBefore(widget.selectEndDateTime!) &&
                        day > 0
                ? true
                : false;
      }

      dayRowChildren.add(
        DayNumber(
          size: widget.itemWidth,
          day: day,
          isToday: isToday,
          isDefaultSelected: isDefaultSelected,
          todayColor: widget.todayColor,
          canSelected: _canSelected,
        ),
      );

      if ((day - 1 + firstWeekdayOfMonth) % DateTime.daysPerWeek == 0 ||
          day == daysInMonth) {
        dayRows.add(
          Row(
            children: List<DayNumber>.from(dayRowChildren),
          ),
        );
        dayRowChildren.clear();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayRows,
    );
  }

  Widget buildMonthView(BuildContext context) {
    return NotificationListener<CalendarNotification>(
      onNotification: (notification) {
        selectedDate =
            DateTime(widget.year, widget.month, notification.selectDay);
        widget.onSelectDayRang(selectedDate);
        return true;
      },
      child: Container(
        width: 7 * TWCalendarTool.getDayNumberSize(context, widget.padding),
        margin: EdgeInsets.all(widget.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 5.w,
              ),
              child: MonthTitle(
                year: widget.year,
                month: widget.month,
                monthNames: widget.monthNames,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.w),
              child: buildMonthDays(context),
            ),
          ],
        ),
      ),
    );
  }

  /* Priavte Method */
  bool canSelectedDate(
      {required DateTime date,
      required bool isToday,
      bool canSeletedToday = false}) {
    if (isToday & !canSeletedToday) {
      // 当天不可以选择
      return false;
    }
    return TWCalendarTool.dateIsBetweenIn(
        date, widget.firstDate, widget.lastDate);
  }
}
