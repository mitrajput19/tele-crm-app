// import 'dart:isolate';
// import 'dart:math';
// import 'dart:ui';

// import 'package:background_locator_2/location_dto.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../app.dart';

// class LocationServiceRepository {
//   static LocationServiceRepository _instance = LocationServiceRepository._();

//   LocationServiceRepository._();

//   factory LocationServiceRepository() {
//     return _instance;
//   }

//   static const String isolateName = 'LocatorIsolate';

//   int _count = -1;

//   Future<void> init(Map<dynamic, dynamic> params) async {
//     print('LocationTracking : ***********Init callback handler');
//     if (params.containsKey('countInit')) {
//       dynamic tmpCount = params['countInit'];
//       if (tmpCount is double) {
//         _count = tmpCount.toInt();
//       } else if (tmpCount is String) {
//         _count = int.parse(tmpCount);
//       } else if (tmpCount is int) {
//         _count = tmpCount;
//       } else {
//         _count = -2;
//       }
//     } else {
//       _count = 0;
//     }
//     print('LocationTracking : $_count');
//     final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
//     send?.send(null);
//   }

//   Future<void> dispose() async {
//     print('LocationTracking : ***********Dispose callback handler');
//     print('LocationTracking : $_count');
//     final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
//     send?.send(null);
//   }

//   Future<void> callback(LocationDto locationDto) async {
//     print('LocationTracking $_count LocationData : ${locationDto.toString()}');
//     await setLogPosition(_count, locationDto);
//     final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
//     send?.send(locationDto.toJson());
//     _count++;
//   }

//   Future<void> saveLocationData(Map<String, dynamic> logData) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> dataList = prefs.getStringList(StorageKeys.backgroundLocationData) ?? [];
//     String serializedData = json.encode(logData);
//     dataList.add(serializedData);
//     await prefs.setStringList(StorageKeys.backgroundLocationData, dataList);
//   }

//   Future<void> setLogPosition(int count, LocationDto data) async {
//     DateTime dateTime = DateTime.now();
//     String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
//     String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
//     Map<String, dynamic> logData = {
//       'count': count,
//       'date': formattedDate,
//       'time': formattedTime,
//       'latitude': data.latitude,
//       'longitude': data.longitude,
//     };

//     await saveLocationData(logData);
//   }

//   static double dp(double val, int places) {
//     num mod = pow(10.0, places);
//     return ((val * mod).round().toDouble() / mod);
//   }

//   static String formatDateLog(DateTime date) {
//     return date.hour.toString() + ':' + date.minute.toString() + ':' + date.second.toString();
//   }

//   static String formatLog(LocationDto locationDto) {
//     return dp(locationDto.latitude, 4).toString() + ' ' + dp(locationDto.longitude, 4).toString();
//   }
// }
