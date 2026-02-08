import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';

class SettingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  Future<void> initSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    _isScheduled = prefs.getBool('schedule') ?? false;
    notifyListeners();
  }

  Future<void> scheduledNotification(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('schedule', value);

    _isScheduled = value;
    notifyListeners();

    if (_isScheduled) {
      WorkmanagerService workmanagerService = WorkmanagerService();
      workmanagerService.scheduleRestaurantNotification();
    } else {
      await workManagerInstance.cancelAll();
    }
  }
}
