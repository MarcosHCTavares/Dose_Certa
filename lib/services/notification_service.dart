import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Inicializa timezones para uso em agendamento
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const windowsSettings = WindowsInitializationSettings(appName: 'dose_certa', 
      appUserModelId: 'defaultUser',
      guid: 'd9b2d63d-a233-4123-847a-7f78e69a2f11',
      ); // adicionado

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      windows: windowsSettings, // adicionado
    );

    await _notifications.initialize(settings);
  }

  /// Agenda uma notificação para um horário específico usando timezone-aware datetime.
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    DateTime now = DateTime.now();

  // Se a data agendada for no passado, ajusta para o próximo dia, mesma hora
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    
    final tz.TZDateTime tzScheduled = tz.TZDateTime.from(scheduledDate, tz.local);

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tzScheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'dose_certa_channel',
          'Dose Certa Notificações',
          channelDescription: 'Notificações para lembrete de medicamentos',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}
