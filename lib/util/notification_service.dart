import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;
import 'package:device_info_plus/device_info_plus.dart';

class LocalNoticeService {
  static final LocalNoticeService _notificationService =
      LocalNoticeService._internal();

  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  factory LocalNoticeService() {
    return _notificationService;
  }
  LocalNoticeService._internal();

  void scheduleDailyNotification(
      int id, String title, String reminderText, int hour, int minute) async {
    var now = DateTime.now();
    var endTime = DateTime(now.year, now.month, now.day, hour, minute)
        .millisecondsSinceEpoch;
    final scheduledDate =
        tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, endTime);

    LocalNoticeService().addNotification(
      id,
      title,
      reminderText,
      scheduledDate,
      channel: 'testing',
    );
  }

  Future<void> addNotification(
    int id,
    String title,
    String body,
    tz.TZDateTime scheduleTime, {
    String sound = '',
    String channel = 'default',
  }) async {
    final androidDetail = AndroidNotificationDetails(
        channel, // channel Id
        channel // channel Name
        );

    const iosDetail = DarwinNotificationDetails();

    final noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );

    await _localNotificationsPlugin.zonedSchedule(
        id, title, body, scheduleTime, noticeDetail,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> cancelNotification(int id) async {
    await _localNotificationsPlugin.cancel(id);
  }

  Future<void> setup() async {
    tzData.initializeTimeZones();

    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    }

    const iosSetting = DarwinInitializationSettings();

    const initSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);

    await _localNotificationsPlugin.initialize(initSettings).then((_) {
      debugPrint('setupPlugin: setup success');
    }).catchError((Object error) {
      debugPrint('Error: $error');
    });
  }
}
