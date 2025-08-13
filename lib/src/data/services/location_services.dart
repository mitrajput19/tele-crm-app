import 'package:location/location.dart';

import '../../app/app.dart';

class LocationServices {
  LocationServices._privateConstructor();

  static Future requestLocationPermission(BuildContext context, {bool isErrorScreen = false}) async {
    final Location location = Location();
    if (isErrorScreen) context.loader(true);
    try {
      // Check if location services are enabled
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          debugPrint('requestLocationPermission : Location services are disabled.');
          return;
        }
      }

      // Check and request location permission
      PermissionStatus permissionGranted = await location.hasPermission();
      debugPrint('requestLocationPermission : hasPermission $permissionGranted');

      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        debugPrint('requestLocationPermission denied : requestPermission $permissionGranted');
        if (permissionGranted == PermissionStatus.denied || permissionGranted == PermissionStatus.deniedForever) {
          // debugPrint('requestLocationPermission Step 1 : $isErrorScreen : ${AppRoutes.locationPermission}');
          // context.go(AppRoutes.locationPermission);
          return;
        }
        if (!serviceEnabled) {
          serviceEnabled = await location.requestService();
          if (!serviceEnabled) {
            debugPrint('requestLocationPermission : Location services are disabled.');
            return;
          }
        }
      }

      // Handle the case when permission is permanently denied
      if (permissionGranted == PermissionStatus.deniedForever) {
        debugPrint('requestLocationPermission deniedForever : requestPermission $permissionGranted');
        debugPrint('requestLocationPermission Step 2 $isErrorScreen : ${AppRoutes.splash}');
        // context.go(AppRoutes.locationPermission);
      }

      // Proceed only if permission is granted
      if (permissionGranted == PermissionStatus.granted) {
        debugPrint('requestLocationPermission : getLocation');
        LocationData locationData = await location.getLocation();

        debugPrint('requestLocationPermission : locationDetails');
        var locationDetails = LocationDetails(
          latitude: locationData.latitude!,
          longitude: locationData.longitude!,
        );

        debugPrint('requestLocationPermission : setLocationData');
        await getIt<StorageServices>().setLocationData(locationDetails.toJson());

        if (isErrorScreen) {
          debugPrint('requestLocationPermission Step 3 $isErrorScreen : ${AppRoutes.splash}');
          context.go(AppRoutes.splash);
        } else {
        
        }
        debugPrint('requestLocationPermission : Location permission granted.');
        
        return;
      } else {
        debugPrint('requestLocationPermission : Location permission denied.');
        return;
      }
    } on PlatformException catch (e) {
      debugPrint('requestLocationPermission : Error requesting location permission: ${e.code} - ${e.message}');
      LogHelper.log(e);
      return;
    } catch (e) {
      debugPrint('requestLocationPermission : Unexpected error requesting location permission: $e');
      LogHelper.log(e);
      return;
    } finally {
      if (isErrorScreen) context.loader(false);
    }
  }
}
