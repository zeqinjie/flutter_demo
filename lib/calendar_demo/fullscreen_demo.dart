/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-20 22:19:33
 * @Description: your project
 */
import 'package:flutter/material.dart';
import 'calendar/calendar_list.dart';

class TWCalendarView extends StatefulWidget {
  const TWCalendarView({
    Key? key,
  }) : super(key: key);

  @override
  _TWCalendarViewState createState() => _TWCalendarViewState();
}

class _TWCalendarViewState extends State<TWCalendarView> {
  @override
  Widget build(BuildContext context) {
    return CalendarList(
      firstDate: DateTime(2022, 7, 3),
      lastDate: DateTime(2022, 9, 21),
      selectedStartDate: DateTime(2022, 8, 28),
      selectedEndDate: DateTime(2022, 9, 2),
      onSelectFinish: (selectStartTime, selectEndTime) {
        List<DateTime> result = <DateTime>[];
        result.add(selectStartTime);
        if (selectEndTime != null) {
          result.add(selectEndTime);
        }
        Navigator.pop(context, result);
      },
    );
  }
}
