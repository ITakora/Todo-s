import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        )
      ],
      debug: true,
    );

    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};
    if (payload["done"] == "true") {}
  }

  static Future<void> myNotifyScheduleInHours({
    required String title,
    final ActionType actionType = ActionType.Default,
    // required int id,
    required int hours,
    required int minutes,
    // required final List<NotificationActionButton>? actionButtons,
    bool repeatNotif = false,
  }) async {
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    // var nowDate = DateTime.now().add(Duration(hours: hoursFromNow, seconds: 5));
    await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
          //weekday: nowDate.day,
          hour: hours,
          minute: minutes,
          repeats: repeatNotif,
          allowWhileIdle: true,
          preciseAlarm: true,
          timeZone: localTimeZone,
          second: 0
          //allowWhileIdle: true,
          ),
      // schedule: NotificationCalendar.fromDate(
      //    date: DateTime.now().add(const Duration(seconds: 10))),
      content: NotificationContent(
        id: 1,
        channelKey: 'high_importance_channel',
        title: title,
        body: 'Waktu ke $hours : $minutes',
        notificationLayout: NotificationLayout.Default,
        //actionType : ActionType.DismissAction,

        // customSound: 'resource://raw/notif',
      ),
      // actionButtons: actionButtons
    );
  }
}
