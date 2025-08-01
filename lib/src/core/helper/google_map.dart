
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../app/app.dart';

class GoogleMapsViewer extends StatefulWidget {
  final double latitude;
  final double longitude;
  const GoogleMapsViewer({super.key, required this.latitude, required this.longitude,});

  @override
  State<GoogleMapsViewer> createState() => _GoogleMapsViewerState();
}

class _GoogleMapsViewerState extends State<GoogleMapsViewer> {
  late LatLng _location;
  GoogleMapController? _mapController;

  void _openInGoogleMaps(BuildContext context) {
    final lat = _location.latitude;
    final lng = _location.longitude;
    String url;
    if (Platform.isAndroid) {
      url = 'geo:\u0000$lat,$lng?q=$lat,$lng(Home Revise)';
    } else if (Platform.isIOS) {
      url = 'https://maps.apple.com/?ll=$lat,$lng&q=Home+Revise';
    } else {
      url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    }
   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _location = LatLng(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition:  CameraPosition(
        target: _location,
        zoom: 17.5,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('target-location'),
          position: _location,
           infoWindow: const InfoWindow(
            title: 'Home Revise',
            // snippet: '',
          ),
        ),
      },
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
     
        Future.delayed(const Duration(milliseconds: 500), () {
          if (_mapController != null) {
            _mapController!.showMarkerInfoWindow(const MarkerId('target-location'));
          }
        });
      },
    );
  }
}
