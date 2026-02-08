import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';

import '../../bootstrap/app_bootstrap.dart';
import '../../di/app_injection.dart';
import '../../features/restaurant/restaurant.dart';
import '../core.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    await injection();

    final notificationHelper = NotificationHelper();
    WorkmanagerService workmanagerService = WorkmanagerService();

    final restaurants = await GetRestaurantsUseCase(locator()).call(NoParams());

    await restaurants.fold(
      (error) {
        AppLog.logger.e('Notification error: $error');
      },
      (result) async {
        await notificationHelper.showNotification(
          flutterLocalNotificationsPlugin,
          result.restaurantList,
        );
      },
    );

    workmanagerService.scheduleRestaurantNotification();

    return Future.value(true);
  });
}

class WorkmanagerService {
  Future<void> scheduleRestaurantNotification() async {
    await workManagerInstance.registerOneOffTask(
      "scheduledNotification",
      "showNotificationRestaurant",
      constraints: Constraints(networkType: NetworkType.connected),
      initialDelay: DateTimeHelper.scheduleTime(),
    );
  }

  Future<void> cancelAllTask() async {
    await workManagerInstance.cancelAll();
  }
}
