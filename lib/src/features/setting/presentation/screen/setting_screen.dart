import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/setting_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingProvider()..initSchedule(),
      child: Scaffold(
        body: SafeArea(
          child: Material(
            child: ListTile(
              title: const Text('Scheduling Notification'),
              trailing: Consumer<SettingProvider>(
                builder: (context, scheduled, _) => Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) {
                    scheduled.scheduledNotification(value);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
