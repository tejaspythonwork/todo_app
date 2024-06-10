// import 'dart:developer';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:todo_app/main.dart';

// class NotificationServices {
//   static final notificationPlugin = FlutterLocalNotificationsPlugin();

//   static Future initialisePlugin() async {
//     AndroidInitializationSettings androidSettings =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');

//     InitializationSettings androidInitialseSettings =
//         InitializationSettings(android: androidSettings);

//     notificationPlugin.initialize(androidInitialseSettings,
//         onDidReceiveNotificationResponse: notificationTapBackground,
//         onDidReceiveBackgroundNotificationResponse: notificationTapForeground);
//   }

//   // static didReceiveNotificationResponse(
//   //   NotificationResponse notificationDetails,
//   // ) async {
//   //   final String? payload = notificationDetails.payload;
//   //   log(payload.toString());
//   //   if (payload != null) {
//   //     MyApp.navigatorKey.currentState
//   //         ?.pushNamed('/details', arguments: payload);
//   //   }
//   //   switch (notificationDetails.notificationResponseType) {
//   //     case NotificationResponseType.selectedNotification:
//   //       MyApp.navigatorKey.currentState
//   //           ?.pushNamed('/details', arguments: payload);
//   //       break;
//   //     case NotificationResponseType.selectedNotificationAction:
//   //       //if (notificationDetails.actionId == 'ID_1') {
//   //       ///MyApp.navigatorKey.currentState?.pushNamed('/details', arguments: payload);
//   //       MyApp.navigatorKey.currentState
//   //           ?.pushNamed('/details', arguments: payload);
//   //       log('ID_1 notification action button clicked');
//   //       // }
//   //       break;
//   //   }
//   // }

//   showSimpleNotification(String title, String body, String payload) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       '111',
//       'your channel name',
//       channelDescription: 'your channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await notificationPlugin.show(
//         1, 'plain title', 'plain body', notificationDetails,
//         payload: 'item x');
//   }

//   // static Future notificationTapForeground(
//   //     NotificationResponse notificationResponse) async {
//   //   try {
//   //     log('======');
//   //     log('Foreground Notification');
//   //     log('Notification Response Id - ${notificationResponse.id}');
//   //     log('Notification Action Id - ${notificationResponse.actionId}');
//   //     log('Payload - ${notificationResponse.payload}');
//   //     log('======');
//   //     final payload = notificationResponse.payload;
//   //     if (payload != null) {
//   //       MyApp.navigatorKey.currentState
//   //           ?.pushNamed('/details', arguments: payload);
//   //     }
//   //     switch (notificationResponse.notificationResponseType) {
//   //       case NotificationResponseType.selectedNotification:
//   //         MyApp.navigatorKey.currentState
//   //             ?.pushNamed('/details', arguments: payload);
//   //         break;
//   //       case NotificationResponseType.selectedNotificationAction:
//   //         if (notificationResponse.actionId == 'ID_1') {
//   //           ///MyApp.navigatorKey.currentState?.pushNamed('/details', arguments: payload);
//   //           MyApp.navigatorKey.currentState
//   //               ?.pushNamed('/details', arguments: payload);
//   //           log('ID_1 notification action button clicked');
//   //         }
//   //         break;
//   //     }
//   //     log('Navigate to another page');
//   //   } catch (e) {
//   //     log(e.toString());
//   //   }
//   // }
//   static Future<void> notificationTapForeground(
//       NotificationResponse notificationResponse) async {
//     log('======');
//     log('Foreground Notification');
//     log('Notification Response Id - ${notificationResponse.id}');
//     log('Notification Action Id - ${notificationResponse.actionId}');
//     log('Payload - ${notificationResponse.payload}');
//     log('======');
//     final payload = notificationResponse.payload;
//     if (payload != null) {
//       MyApp.navigatorKey.currentState
//           ?.pushNamed('/details', arguments: payload);
//     }
//     switch (notificationResponse.notificationResponseType) {
//       case NotificationResponseType.selectedNotification:
//         MyApp.navigatorKey.currentState
//             ?.pushNamed('/details', arguments: payload);
//         break;
//       case NotificationResponseType.selectedNotificationAction:
//         // if (notificationResponse.actionId == 'ID_1') {
//         ///MyApp.navigatorKey.currentState?.pushNamed('/details', arguments: payload);
//         MyApp.navigatorKey.currentState
//             ?.pushNamed('/details', arguments: payload);
//         log('ID_1 notification action button clicked');
//         //   }
//         break;
//     }

//     log('Navigate to another page');
//   }

//   static Future<void> notificationTapBackground(
//       NotificationResponse notificationResponse) async {
//     log('=======');
//     log('Notification Response Id - ${notificationResponse.id}');
//     log('Notification Action Id - ${notificationResponse.actionId}');
//     log('Payload - ${notificationResponse.payload}');
//     log('=======');
//     final payload = notificationResponse.payload;
//     if (payload != null) {
//       MyApp.navigatorKey.currentState
//           ?.pushNamed('/details', arguments: payload);
//     }
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:todo_app/main.dart';
import 'package:todo_app/ui/detail_screen.dart';

class NotificationServices {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int id = 0;

  static Future init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings darwinSettings = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => () {},
    );

    final InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        onDidReceiveNotificationResponse: notificationTapForeground);
  }

  // Future<void> _onSelectNotification(String? payload) async {
  //   if (payload != null) {
  //     if (await canLaunch(payload)) {
  //       await launch(payload);
  //     } else {
  //       throw 'Could n  ot launch $payload';
  //     }
  //   }
  // }

  static Future<void> notificationTapForeground(
      NotificationResponse notificationResponse) async {
    log('======');
    log('Foreground Notification');
    log('Notification Response Id - ${notificationResponse.id}');
    log('Notification Action Id - ${notificationResponse.actionId}');
    log('Payload - ${notificationResponse.payload}');
    log('======');
    final payload = notificationResponse.payload;
    // if (payload != null) {
    //   MyApp.navigatorKey.currentState
    //       ?.pushNamed('/details', arguments: payload);
    // }
    Get.toNamed('/details', arguments: payload);
    switch (notificationResponse.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        // MyApp.navigatorKey.currentState?.push(
        //     MaterialPageRoute(builder: (context) => const DetailScreen()));
        break;
      case NotificationResponseType.selectedNotificationAction:
        //if (notificationResponse.actionId == 'ID_1') {
        ///MyApp.navigatorKey.currentState?.pushNamed('/details', arguments: payload);
        MyApp.navigatorKey.currentState
            ?.pushNamed('/details', arguments: payload);
        log('ID_1 notification action button clicked');
        //  }
        break;
    }

    log('Navigate to another page');
  }

  static Future<void> notificationTapBackground(
      NotificationResponse notificationResponse) async {
    log('=======');
    log('Notification Response Id - ${notificationResponse.id}');
    log('Notification Action Id - ${notificationResponse.actionId}');
    log('Payload - ${notificationResponse.payload}');
    log('=======');
  }

  static Future<void> showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '1101',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        18, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

  static Future<void> showNotificationWithTextAction() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      '1',
      'Text Action Channel',
      channelDescription: 'Notification With Text',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      ledColor: Colors.amber,
      ledOnMs: 11,
      ledOffMs: 10,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'ID_1',
          'Action 1',
          icon: DrawableResourceAndroidBitmap(
            'food',
          ),
          showsUserInterface: true,
          contextual: true,
        ),
        AndroidNotificationAction(
          'ID_2',
          'Action 2',
          titleColor: Colors.green,
          icon: DrawableResourceAndroidBitmap(
            'secondary_icon',
          ),
          contextual: true,
        ),
        AndroidNotificationAction('ID_3', 'Action 3',
            titleColor: Colors.purple,
            icon: DrawableResourceAndroidBitmap('me')),
      ],
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      100,
      'Notification with action and payload',
      'Notification Body',
      notificationDetails,
      payload: 'Item Z',
    );
  }
}
