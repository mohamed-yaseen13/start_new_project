import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show atan2, cos, pi, pow, sin, sqrt;
import '../../features/language/presentation/provider/language_provider.dart';
import '../dialog/snack_bar.dart';

String? currentLocationAddress;
LatLng? muCurrentLocation;
Future<LatLng> determinePosition({
  bool showMessage = true,
  bool fromHome = false,
}) async {
  // await  delay(2000);
  if (muCurrentLocation != null) {
    return muCurrentLocation!;
  }
  LocationPermission permission;
  LatLng defaultLatLng = const LatLng(24.7136, 46.6753);
  muCurrentLocation = defaultLatLng;
  // return defaultLatLngq;
  // تحقق من إذن الموقع
  try {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (showMessage) {
          await showSettingsDialog(
            LanguageProvider.translate('warning', 'open_gps'),
          );
        }
        return defaultLatLng;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (showMessage) {
        await showSettingsDialog('open_gps_settings');
      }
      return defaultLatLng;
    }
    try {
      Position position = await Geolocator.getCurrentPosition();
      LatLng latLng = LatLng(position.latitude, position.longitude);
      muCurrentLocation = latLng;
      return latLng;
    } catch (e) {
      if (showMessage) {
        await showSettingsDialog('location_error');
      }
      return defaultLatLng;
    }
  } catch (e) {
    if (showMessage) {
      await showSettingsDialog('location_error');
    }
    return defaultLatLng;
  }
}

Future showSettingsDialog(String title) async {
  showToast(LanguageProvider.translate('warning', title));
}

double calculateDistance(LatLng location1, LatLng location2) {
  const double earthRadius = 6371; // Radius of the Earth in kilometers

  // Convert latitude and longitude from degrees to radians
  double lat1 = _degreesToRadians(location1.latitude);
  double lon1 = _degreesToRadians(location1.longitude);
  double lat2 = _degreesToRadians(location2.latitude);
  double lon2 = _degreesToRadians(location2.longitude);

  // Calculate differences between latitudes and longitudes
  double dLat = lat2 - lat1;
  double dLon = lon2 - lon1;

  // Calculate the distance using Haversine formula
  double a =
      pow(sin(dLat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = earthRadius * c; // Distance in kilometers

  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}
