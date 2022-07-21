/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-21 14:26:50
 * @Description: your project
 */

import 'package:flutter/material.dart';

class TWCalendarTool {
  static double getMonthViewHeight(BuildContext context) {
    const double padding = 8.0;
    const double titleHeight = 21.0;

    return (2 * padding) +
        titleHeight +
        8.0 +
        (6 * TWCalendarTool.getDayNumberSize(context, 0));
  }

  static double getDayNumberSize(BuildContext context, double padding) {
    return (MediaQuery.of(context).size.width - padding * 2) / 7;
  }

  static bool dateIsToday(DateTime date) {
    final DateTime now = DateTime.now();
    return date.isAtSameMomentAs(DateTime(now.year, now.month, now.day));
  }

  /// 在过去和未来直接
  static bool dateIsBetweenIn(
      DateTime date, DateTime firstDate, DateTime lastDate) {
    final r1 = date.compareTo(firstDate);
    final r2 = date.compareTo(lastDate);
    if ((r1 == 1 || r1 == 0) && (r2 == -1 || r2 == 0)) {
      return true;
    }
    return false;
  }

  static int getDaysInMonth(int year, int month) {
    return month < DateTime.monthsPerYear
        ? DateTime(year, month + 1, 0).day
        : DateTime(year + 1, 1, 0).day;
  }

  static String getMonthName(
    int month, {
    List<String>? monthNames,
  }) {
    final List<String> names = monthNames ??
        <String>[
          '01月',
          '02月',
          '03月',
          '04月',
          '05月',
          '06月',
          '07月',
          '08月',
          '09月',
          '10月',
          '11月',
          '12月',
        ];
    return names[month - 1];
  }

  static String getYearName(
    int year,
  ) {
    return '$year年';
  }

  /// 选择标题
  static String? getSelectedDaysTitle(
    DateTime? selectStartTime,
    DateTime? selectEndTime,
  ) {
    if (selectStartTime != null && selectEndTime != null) {
      return '${selectStartTime.month}.${selectStartTime.day}-${selectEndTime.month}.${selectEndTime.day}';
    }
    if (selectStartTime != null && selectEndTime == null) {
      return '${selectStartTime.month}.${selectStartTime.day}';
    }
    return null;
  }

  /// 选择天数
  static int getSelectedDays(
    DateTime? selectStartTime,
    DateTime? selectEndTime,
  ) {
    if (selectStartTime != null && selectEndTime != null) {
      final d = selectEndTime.difference(selectStartTime);
      return d.inDays + 1;
    }
    if (selectStartTime != null) {
      return 1;
    }
    return 0;
  }
}
