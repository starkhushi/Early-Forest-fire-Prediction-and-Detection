import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

Future<double> fetchWindSpeed() async {
  Position position = await getCurrentLocation();
  final response = await http.get(
    Uri.parse('http://api.weatherapi.com/v1/current.json?key=daa388f48c6c48b4a9c92904241005&q=${position.latitude},${position.longitude}'),
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data['current']['wind_mph'];
  } else {
    throw Exception('Failed to load wind speed');
  }
}

Future<Position> getCurrentLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    throw Exception('Location permissions are denied');
  }
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}