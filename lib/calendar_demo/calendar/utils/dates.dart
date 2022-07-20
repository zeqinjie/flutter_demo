/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-20 22:42:11
 * @Description: your project
 */
bool dateIsToday(DateTime date) {
  final DateTime now = DateTime.now();
  return date.isAtSameMomentAs(DateTime(now.year, now.month, now.day));
}

int getDaysInMonth(int year, int month) {
  return month < DateTime.monthsPerYear
      ? DateTime(year, month + 1, 0).day
      : DateTime(year + 1, 1, 0).day;
}

String getMonthName(
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

String getYearName(
  int year,
) {
  return '$year年';
}
