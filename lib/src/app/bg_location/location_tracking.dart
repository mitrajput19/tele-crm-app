// import 'dart:isolate';
// import 'dart:ui';

// import 'package:background_locator_2/background_locator.dart';
// import 'package:background_locator_2/location_dto.dart';
// import 'package:background_locator_2/settings/android_settings.dart';
// import 'package:location/location.dart';

// import 'location_callback_handler.dart';
// import 'location_service_repository.dart';

// class LocationTrackingManager {
//   static final ReceivePort _port = ReceivePort();
//   static final Location _location = Location();

//   static Future<void> startLocationTracking() async {
//     if (IsolateNameServer.lookupPortByName(LocationServiceRepository.isolateName) != null) {
//       IsolateNameServer.removePortNameMapping(
//         LocationServiceRepository.isolateName,
//       );
//     }
//     IsolateNameServer.registerPortWithName(
//       _port.sendPort,
//       LocationServiceRepository.isolateName,
//     );
//     _port.listen((dynamic data) async => await _updateUI(data));
//     _initPlatformState();
//     if (await _checkLocationPermission()) {
//       await _startLocator();
//       await BackgroundLocator.isServiceRunning();
//     }
//   }

//   static Future<void> _updateUI(dynamic data) async {
//     LocationDto? locationDto = (data != null) ? LocationDto.fromJson(data) : null;
//     await _updateNotificationText(locationDto);
//   }

//   static Future<void> _updateNotificationText(LocationDto? data) async {
//     if (data == null) return;
//     await BackgroundLocator.updateNotificationText(
//       title: 'Location Update',
//       msg: '${DateTime.now()}',
//       bigMsg: '${data.latitude}, ${data.longitude}',
//     );
//   }

//   static Future<void> _initPlatformState() async {
//     print('LocationTracking : Initializing...');
//     await BackgroundLocator.initialize();
//     print('LocationTracking : Initialization done');
//     await BackgroundLocator.isServiceRunning();
//   }

//   static Future<bool> _checkLocationPermission() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//       if (!serviceEnabled) return false;
//     }

//     permissionGranted = await _location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) return false;
//     }

//     return true;
//   }

//   static Future<void> _startLocator() async {
//     print('LocationTracking : startLocator');
//     Map<String, dynamic> data = {'countInit': 1};
//     return await BackgroundLocator.registerLocationUpdate(
//       LocationCallbackHandler.callback,
//       initDataCallback: data,
//       initCallback: LocationCallbackHandler.initCallback,
//       disposeCallback: LocationCallbackHandler.disposeCallback,
//       androidSettings: AndroidSettings(
//         interval: 10,
//         androidNotificationSettings: AndroidNotificationSettings(
//           notificationIcon: '@drawable/notification_icon',
//         ),
//       ),
//     );
//   }
// }
