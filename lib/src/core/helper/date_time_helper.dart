class DateTimeHelper {
  static Duration scheduleTime() {
    final now = DateTime.now();

    DateTime target = DateTime(now.year, now.month, now.day, 11, 0, 0);

    if (now.isAfter(target)) {
      target = target.add(const Duration(days: 1));
    }

    return target.difference(now);
  }
}
