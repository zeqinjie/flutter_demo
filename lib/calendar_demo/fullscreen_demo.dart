/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-20 16:47:02
 * @Description: your project
 */
import 'package:flutter/material.dart';
import 'calendar/calendar_list.dart';

class TWCalendarFullScreen extends StatefulWidget {
  const TWCalendarFullScreen({
    Key? key,
  }) : super(key: key);

  @override
  _TWCalendarFullScreenState createState() => _TWCalendarFullScreenState();
}

class _TWCalendarFullScreenState extends State<TWCalendarFullScreen> {
  @override
  Widget build(BuildContext context) {
    return CalendarList(
      firstDate: DateTime(2022, 8, 1),
      lastDate: DateTime(2022, 9, 2),
//      selectedStartDate: DateTime(2019, 8, 28),
//      selectedEndDate: DateTime(2019, 9, 2),
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
