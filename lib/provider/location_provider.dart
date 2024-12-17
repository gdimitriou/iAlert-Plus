import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  double _latitude = 0.0;
  double _longitude = 0.0;

  double get latitude => _latitude;
  double get longitude => _longitude;

  Future<void> updateLocation() async {
    final location = Location();
    final locationData = await location.getLocation();
    _latitude = locationData.latitude ?? 0.0;
    _longitude = locationData.longitude ?? 0.0;
    notifyListeners();
  }
}