import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void callPhone(String phone) async {
  final Uri uri = Uri(
    scheme: 'tel',
    path: phone,
  );
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    print('Could not launch call');
  }
}


Future<Stream<Position>> initGeolocation() async {
  print('DIAG init geolocation called');
  final locationSettings = AndroidSettings(
    accuracy: LocationAccuracy.high,
    intervalDuration: const Duration(seconds: 10),
    foregroundNotificationConfig: const ForegroundNotificationConfig(
      notificationText:
      "The app will continue to receive your location even when you aren't using it",
      notificationTitle: "Running in Background",
      enableWakeLock: true,
    ),
  );
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  print('DIAG ServiceEnabled: $serviceEnabled');

  permission = await Geolocator.checkPermission();
  print('DIAG permission: $permission');
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location Permission Denied');
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  } else if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return Geolocator.getPositionStream(locationSettings: locationSettings);
}
