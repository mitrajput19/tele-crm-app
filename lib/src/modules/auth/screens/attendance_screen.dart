

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/app.dart';
import '../../../core/widgets/common_slide_button.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  GoogleMapController? _mapController;
  LocationDetails? _currentLocation;
  bool _isLoading = true;
  bool _isPunchLoading = false;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadCurrentLocation();
    });
  }

  Future<void> _loadCurrentLocation() async {
    try {
      var locationData = await getIt<StorageServices>().getLocationData();
      setState(() {
        _currentLocation = locationData; 
        _isLoading = false;
      });
    } catch (e) {
      // Handle error case
      print('Error loading location: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _currentLocation != null
              ? Column(
                children: [
                  Expanded(
                    child: GoogleMapsViewer(
                        latitude: _currentLocation!.latitude ?? 0.0,
                        longitude: _currentLocation!.longitude ?? 0.0,
                      ),
                      
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CommonSlideButton(
                          label: AppStrings.punchIn,
                          onConfirmation: (controller) async {
                            controller.loading();
                            CommonFilePicker(
                      onSelectTap: (filesList) {
                       
                        setState(() {});
                      },
                    );
                            setState(() {
                              _isPunchLoading = true;
                            });
                            await Future.delayed(Duration(seconds: 2));
                            controller.success();
                            setState(() {
                              _isPunchLoading = false;
                            });
                             await Future.delayed(Duration(seconds: 1));
                            controller.reset();
                          }
                        ),
                  ),
                ],
              )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Location not available',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 16),
                      CommonFilledButton(
                        label: 'Retry',
                        onPressed: () async => _loadCurrentLocation()
                      )
                    ],
                  ),
                ),
    );
  }
}