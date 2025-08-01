// import 'dart:math';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';

// import '../../app/app.dart';

// @pragma('vm:entry-point')
// Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
//   LogHelper.log('onActionReceivedMethod : ${receivedAction.payload}');
//   getIt<NotificationServices>().handelNotificationClick(receivedAction.payload);
// }

// @pragma('vm:entry-point')
// Future<void> notificationTapBackground(NotificationResponse notificationResponse) async {
//   LogHelper.log(
//     notificationResponse.payload,
//     tag: 'onDidReceiveBackgroundNotificationResponse',
//   );
//   getIt<NotificationServices>().handelNotificationClick(notificationResponse.payload);
// }

// @pragma('vm:entry-point')
// Future<void> onBackgroundNotificationReceive(RemoteMessage message) async {
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     importance: Importance.max,
//   );

//   final localNotification = FlutterLocalNotificationsPlugin();

//   try {
//     await localNotification.initialize(
//       InitializationSettings(
//         android: AndroidInitializationSettings(
//           '@drawable/notification_icon',
//         ),
//       ),
//       onDidReceiveNotificationResponse: (NotificationResponse data) {
//         LogHelper.log('onDidReceiveNotificationResponse');
//         LogHelper.log(jsonDecode(data.payload ?? '{}'), tag: 'onDidReceiveNotificationResponse');
//         if (data.payload != null) {
//           Map<String, dynamic> message = jsonDecode(data.payload!);
//           getIt<NotificationServices>().handelNotificationClick(message);
//         }
//       },
//       onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//     );
//   } catch (e) {
//     LogHelper.log(e, name: NotificationServices);
//   }

//   await localNotification
//       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   getIt<NotificationServices>().sendLocalNotification(
//     notificationChannel: channel,
//     remoteMessage: message,
//     isBackground: true,
//   );
// }

// class NotificationServices {
//   static final localNotification = FlutterLocalNotificationsPlugin();

//   DateTime? _tokenExpiry;
//   String? _cachedToken;

//   String getNotificationTopic(int? accountId, int? employeeId, String topic) {
//     return 'emp_${accountId}_${employeeId}_${topic}';
//   }

//   Future<void> subscribeToNotificationTopic(String topic) async {
//     try {
//       await firebaseMessaging.subscribeToTopic(topic);
//       LogHelper.log('subscribeToTopic : $topic');
//     } catch (e) {
//       LogHelper.log('subscribeToTopic Error : $topic : $e');
//     }
//   }

//   Future<void> unsubscribeFromNotificationTopic(String topic) async {
//     try {
//       await firebaseMessaging.unsubscribeFromTopic(topic);
//       LogHelper.log('unsubscribeFromTopic : $topic');
//     } catch (e) {
//       LogHelper.log('unsubscribeFromTopic Error : $topic : $e');
//     }
//   }

//   // Generate OAuth2 token for FCM authorization
//   Future<String> getFirebaseAccessToken() async {
//     // Check if we have a valid cached token
//     if (_cachedToken != null && _tokenExpiry != null) {
//       if (_tokenExpiry!.isAfter(DateTime.now())) {
//         return _cachedToken!;
//       }
//     }

//     try {
//       // Load service account credentials
//       final String jsonString = await rootBundle.loadString(
//         'assets/firebase_service_account.json',
//       );

//       final Map<String, dynamic> serviceAccount = json.decode(jsonString);

//       // Validate required fields
//       if (serviceAccount['private_key'] == null) {
//         throw Exception('Private key is missing from service account JSON');
//       }

//       // Prepare claims
//       final int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//       final claims = {
//         'iss': serviceAccount['client_email'],
//         'sub': serviceAccount['client_email'],
//         'aud': 'https://oauth2.googleapis.com/token',
//         'iat': now,
//         'exp': now + 3600, // 1 hour expiration
//         'scope': 'https://www.googleapis.com/auth/firebase.messaging',
//       };

//       // Ensure private key is properly formatted
//       String privateKey = serviceAccount['private_key'];
//       if (!privateKey.contains('BEGIN PRIVATE KEY')) {
//         privateKey = '-----BEGIN PRIVATE KEY-----\n$privateKey\n-----END PRIVATE KEY-----';
//       }

//       // Create and sign the JWT
//       final jwt = JWT(
//         claims,
//         issuer: serviceAccount['client_email'],
//       );

//       // Sign the token
//       final signedToken = jwt.sign(
//         RSAPrivateKey(privateKey),
//         algorithm: JWTAlgorithm.RS256,
//       );

//       // Detailed logging for debugging
//       print('Signed JWT: $signedToken');
//       print('Requesting access token...');

//       // Exchange for access token
//       final response = await http.post(
//         Uri.parse('https://oauth2.googleapis.com/token'),
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
//           'assertion': signedToken,
//         },
//       );

//       // Detailed response logging
//       print('Response Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//         final tokenData = json.decode(response.body);
//         _cachedToken = tokenData['access_token'];
//         _tokenExpiry = DateTime.now().add(Duration(seconds: tokenData['expires_in']));

//         return _cachedToken!;
//       } else {
//         throw Exception('Failed to get access token.');
//       }
//     } catch (e, stackTrace) {
//       print('Full error details:');
//       print(e);
//       print(stackTrace);
//       throw Exception('Error generating access token: $e');
//     }
//   }

//   Future<void> sendChatNotification({
//     String? topic,
//     String? title,
//     String? body,
//     required String additionalData,
//   }) async {
//     var payload = {
//       'message': {
//         'topic': topic,
//         'notification': {
//           'title': title,
//           'body': body,
//         },
//         'data': {
//           'click_action': 'chat',
//           'additional_data': additionalData,
//         },
//         'android': {
//           'collapse_key': title,
//           'notification': {
//             'tag': title,
//           }
//         },
//       }
//     };

//     try {
//       // Get Firebase access token
//       String? token = await getIt<NotificationServices>().getFirebaseAccessToken();
//       LogHelper.log('FirebaseAccessToken: $token');

//       // Send notification via network service
//       await getIt<NetworkServices>().postFirebaseNotification(data: payload, token: token);
//     } catch (e) {
//       LogHelper.log('Error sending notification: $e');
//     }
//   }

//   Future<void> requestNotificationPermission() async {
//     LogHelper.log('requestNotificationPermission');

//     NotificationSettings settings = await firebaseMessaging.requestPermission(
//       criticalAlert: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       LogHelper.log('requestNotificationPermission : User granted permission');
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       LogHelper.log('requestNotificationPermission : User granted provisional permission');
//     } else {
//       LogHelper.log('requestNotificationPermission : User declined or has not accepted permission');
//     }

//     // await AwesomeNotifications().initialize(
//     //   'resource://drawable/notification_icon',
//     //   [
//     //     NotificationChannel(
//     //       channelGroupKey: 'reminder_channel_group',
//     //       channelKey: 'reminder_channel',
//     //       channelName: 'Reminder Notifications',
//     //       channelDescription: 'This channel is used for reminder notification',
//     //       importance: NotificationImportance.Max,
//     //       criticalAlerts: true,
//     //     )
//     //   ],
//     //   channelGroups: [
//     //     NotificationChannelGroup(
//     //       channelGroupKey: 'reminder_channel_group',
//     //       channelGroupName: 'Reminder Notifications',
//     //     )
//     //   ],
//     //   debug: true,
//     // );

//     // List<NotificationPermission> permissionList = await AwesomeNotifications().checkPermissionList(
//     //   channelKey: 'reminder_channel',
//     //   permissions: [
//     //     NotificationPermission.CriticalAlert,
//     //     NotificationPermission.OverrideDnD,
//     //   ],
//     // );

//     // if (!permissionList.contains(NotificationPermission.CriticalAlert)) {
//     //   LogHelper.log('Awesome Notifications : CriticalAlert');

//     //   await AwesomeNotifications().requestPermissionToSendNotifications(
//     //     channelKey: 'reminder_channel',
//     //     permissions: [
//     //       NotificationPermission.CriticalAlert,
//     //     ],
//     //   );
//     // }

//     // if (!permissionList.contains(NotificationPermission.OverrideDnD)) {
//     //   LogHelper.log('Awesome Notifications : OverrideDnD');
//     //   await AwesomeNotifications().showGlobalDndOverridePage();
//     // }
//   }

//   Future initializeNotificationService(BuildContext context) async {
//     // AwesomeNotifications().setListeners(
//     //   onActionReceivedMethod: onActionReceivedMethod,
//     // );

//     await firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'high_importance_channel',
//       'High Importance Notifications',
//       importance: Importance.max,
//     );

//     try {
//       await localNotification.initialize(
//         InitializationSettings(
//           android: AndroidInitializationSettings(
//             '@drawable/notification_icon',
//           ),
//           iOS: DarwinInitializationSettings(),
//         ),
//         onDidReceiveNotificationResponse: (NotificationResponse data) {
//           LogHelper.log('onDidReceiveNotificationResponse');
//           LogHelper.log(jsonDecode(data.payload ?? '{}'), tag: 'onDidReceiveNotificationResponse');
//           if (data.payload != null) {
//             Map<String, dynamic> message = jsonDecode(data.payload!);
//             handelNotificationClick(message);
//           }
//         },
//         onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//       );
//     } catch (e) {
//       LogHelper.log(e, name: NotificationServices);
//     }

//     await localNotification
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       sendLocalNotification(
//         notificationChannel: channel,
//         remoteMessage: message,
//         isBackground: false,
//       );
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       LogHelper.log('onMessageClicked FirebaseMessaging : $message');
//       LogHelper.log('onMessageClicked FirebaseMessaging: ${message.data}');
//       handelNotificationClick(message.data);
//     });
//   }

//   void sendLocalNotification({
//     required AndroidNotificationChannel notificationChannel,
//     required RemoteMessage remoteMessage,
//     required bool isBackground,
//   }) async {
//     LogHelper.log(remoteMessage.toMap(), tag: 'FirebaseMessaging RemoteData');
//     LogHelper.log(remoteMessage.data, tag: 'FirebaseMessaging Messages');

//     Uint8List response;
//     String groupKey = 'chat_group';
//     AndroidNotificationDetails? androidNotificationDetails;
//     Map<String, dynamic> additionalData = {};
//     String actionType = '';

//     if (remoteMessage.data.containsKey('click_action')) {
//       actionType = remoteMessage.data['click_action'] ?? '';
//     }

//     if (remoteMessage.data.containsKey('additional_data')) {
//       additionalData = jsonDecode(remoteMessage.data['additional_data']?.toString() ?? '');
//     }

//     if (remoteMessage.data['has_image'] == 'true') {
//       response = await getIt<NetworkServices>().getImageBytes(remoteMessage.data['image']);
//       androidNotificationDetails = AndroidNotificationDetails(
//         notificationChannel.id,
//         notificationChannel.name,
//         icon: '@drawable/notification_icon',
//         styleInformation: BigPictureStyleInformation(
//           ByteArrayAndroidBitmap.fromBase64String(base64.encode(response)),
//         ),
//       );
//     } else if (actionType == 'chat') {
//       androidNotificationDetails = AndroidNotificationDetails(
//         notificationChannel.id,
//         notificationChannel.name,
//         icon: '@drawable/notification_icon',
//         groupKey: groupKey,
//         styleInformation: BigTextStyleInformation(''),
//       );
//     } else {
//       androidNotificationDetails = AndroidNotificationDetails(
//         notificationChannel.id,
//         notificationChannel.name,
//         icon: '@drawable/notification_icon',
//         styleInformation: BigTextStyleInformation(''),
//       );
//     }

//     RemoteNotification? notification = remoteMessage.notification;
//     AndroidNotification? android = remoteMessage.notification?.android;

//     var notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//     );

//     if (notification != null && android != null && !isBackground && actionType != 'chat') {
//       localNotification.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         notificationDetails,
//         payload: jsonEncode(remoteMessage.data),
//       );
//     } else if (notification != null && actionType == 'chat' && Platform.isAndroid) {
//       localNotification.show(
//         Random().nextInt(10000000),
//         notification.title,
//         notification.body,
//         notificationDetails,
//         payload: jsonEncode(remoteMessage.data),
//       );

//       List<ActiveNotification>? activeNotifications = await localNotification
//           .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//           ?.getActiveNotifications();

//       List<String> lines = [];
//       int chatNotificationCount = 0;

//       activeNotifications!.forEach((element) {
//         if (element.groupKey == groupKey) {
//           lines.add(element.body.toString());
//           chatNotificationCount++;
//         }
//       });

//       InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
//         lines,
//         contentTitle: '${chatNotificationCount - 1} Chat Message',
//         summaryText: '${chatNotificationCount - 1} Chat Message',
//       );

//       AndroidNotificationDetails? androidNotificationDetailsGroup = AndroidNotificationDetails(
//         notificationChannel.id,
//         notificationChannel.name,
//         icon: '@drawable/notification_icon',
//         styleInformation: inboxStyleInformation,
//         groupKey: groupKey,
//         setAsGroupSummary: true,
//       );

//       var notificationDetailsGroup = NotificationDetails(
//         android: androidNotificationDetailsGroup,
//       );

//       localNotification.show(0, '', '', notificationDetailsGroup);
//     }
//   }

//   static Map<String, String?> convertDynamicToStringMap(Map<String, dynamic> dynamicMap) {
//     Map<String, String?> stringMap = {};

//     dynamicMap.forEach((key, value) {
//       if (value is String || value == null) {
//         stringMap[key] = value as String?;
//       } else {
//         stringMap[key] = value.toString();
//       }
//     });

//     return stringMap;
//   }

//   Future showReminderNotification(ReminderDetails reminder) async {
//     Map<String, String?> convertedMap = convertDynamicToStringMap(reminder.toJson());

//     DateTime dateTime = DateTime.parse(reminder.dateTime!);
//     String timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

//     try {
//       bool status = await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: Random().nextInt(9999),
//           channelKey: 'reminder_channel',
//           title: reminder.title,
//           body: reminder.description,
//           category: NotificationCategory.Reminder,
//           locked: true,
//           wakeUpScreen: true,
//           criticalAlert: true,
//         ),
//         schedule: NotificationCalendar(
//           allowWhileIdle: true,
//           timeZone: timeZone,
//           year: dateTime.year,
//           month: dateTime.month,
//           day: dateTime.day,
//           hour: dateTime.hour,
//           minute: dateTime.minute,
//           second: dateTime.second,
//         ),
//       );

//       LogHelper.log('Awesome Notifications : $status');
//       LogHelper.log('Awesome Notifications : $timeZone');
//       LogHelper.log('Awesome Notifications : ${reminder.dateTime}');
//     } catch (e) {
//       LogHelper.log(e);
//     }
//   }

//   Future handelNotificationClick(dynamic messageData) async {
//     await Future.delayed(Duration(milliseconds: 500));
//     dynamic additionalData = {};
//     String actionType = '';

//     if (messageData.containsKey('click_action')) {
//       actionType = messageData['click_action'];
//     }

//     if (messageData.containsKey('additional_data')) {
//       additionalData = jsonDecode(messageData['additional_data']?.toString() ?? '');
//     }

//     LogHelper.log(tag: 'handelNotificationClick : messageData', messageData);
//     LogHelper.log(tag: 'handelNotificationClick : actionType', actionType);
//     LogHelper.log(tag: 'handelNotificationClick : additionalData', additionalData);

//     navigatorKey.currentContext?.go(AppRoutes.main);

//     try {
//        if (actionType == 'dialog') {
//         showDialog(
//           context: navigatorKey.currentContext!,
//           builder: (_) => AlertDialog(
//             elevation: 2,
//             title: Text(
//               additionalData['dialogTitle'],
//               style: Theme.of(navigatorKey.currentContext!).textTheme.tsMedium16,
//               textAlign: TextAlign.center,
//             ),
//             content: Text(
//               additionalData['dialogBody'],
//               style: Theme.of(navigatorKey.currentContext!).textTheme.tsGrayRegular12,
//               textAlign: TextAlign.center,
//             ),
//           ),
//         );
//       } else if (actionType == 'external') {
//         try {
//           final Uri url = Uri.parse(additionalData['externalLink']);
//           if (!await launchUrl(url)) {
//             LogHelper.log('Could not launch ${additionalData['externalLink']}');
//           }
//         } catch (e) {
//           LogHelper.log('Could not launch $e');
//         }
//       }
//     } catch (e) {
//       LogHelper.log(tag: 'onMessageClicked Error', e);
//     }
//   }

//   Future<void> removeAllNotification() async {
//     await localNotification.cancelAll();
//     LogHelper.log(
//       'removeAllNotification',
//       name: NotificationServices,
//     );
//   }

//   Future<void> removeTaskTimerNotification(int id) async {
//     await localNotification.cancel(id);
//     LogHelper.log(
//       'removeNotificationWithTimer',
//       name: NotificationServices,
//     );
//   }

//   Future<void> showTaskTimerNotification({
//     required int id,
//     int? taskId,
//     int? index,
//     String? type,
//     String? description,
//     String? title,
//   }) async {
//     final channel = AndroidNotificationChannel(
//       'high_importance_channel',
//       'High Importance Notifications',
//       importance: Importance.max,
//     );

//     final androidNotificationDetails = AndroidNotificationDetails(
//       channel.id,
//       channel.name,
//       ongoing: true,
//       autoCancel: false,
//       usesChronometer: true,
//       fullScreenIntent: true,
//       priority: Priority.high,
//       importance: Importance.max,
//       icon: '@drawable/notification_icon',
//       visibility: NotificationVisibility.public,
//       when: DateTime.now().millisecondsSinceEpoch - 0 * 1000,
//     );

//     final iosNotificationDetails = DarwinNotificationDetails(
//       presentAlert: false,
//       presentBadge: true,
//       presentSound: false,
//     );

//     final notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: iosNotificationDetails,
//     );

//     Map<String, dynamic> payload = {
//       'id': id,
//       'index': index,
//       'type': type,
//       'title': title,
//       'description': description,
//       'task_id': taskId,
//       'click_action': 'task_details'
//     };

//     if (Platform.isIOS) {
//       int time = 0;
//       Timer? timer;
//       timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
//         time++;
//         final sec = Duration(seconds: time);
//         final formattedDuration =
//             '${sec.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(sec.inSeconds % 60).toString().padLeft(2, '0')}';
//         localNotification.show(
//           id,
//           title,
//           '$description : $formattedDuration',
//           notificationDetails,
//           payload: jsonEncode(payload),
//         );
//       });
//     } else {
//       await localNotification.show(
//         id,
//         title,
//         description,
//         notificationDetails,
//         payload: jsonEncode(payload),
//       );
//     }
//   }
// }
