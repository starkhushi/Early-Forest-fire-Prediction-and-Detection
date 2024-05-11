import 'package:tflite_flutter/tflite_flutter.dart';

Future<int> runModel(
    double temperature, double humidity, double windspeed) async {
  // Load the TFLite model
  final interpreter = await Interpreter.fromAsset('assets/models/model.tflite');

  // Hardcoded values
  double ffmc = 91.7; // Replace with actual value
  double dmc = 26.2; // Replace with actual value
  double dc = 77.5; // Replace with actual value
  double isi = 12.3; // Replace with actual value
  double rain = 0.8;

  // Fetch wind speed
  double wind = 5.4;

  // Fetch temp and rh values from Realtime Database
  double temp = 900;
  double rh = 30;

  // Prepare input data
  List<double> input = [ffmc, dmc, dc, isi, temp, rh, wind, rain];

  // Run inference on the model
  List<List<double>> outputList = List.filled(1, List.filled(1, 0.0));
  interpreter.run(input, outputList);

  // Process output to obtain predictions
  int output = outputList[0][0].round();

  return output;
}

Future<double> runFWIModel(
    double temperature, double humidity, double windspeed) async {
  // Load the TFLite model
  final interpreter =
      await Interpreter.fromAsset('assets/models/model_try.tflite');

  // Hardcoded values
  double ffmc = 91.7; // Replace with actual value
  double dmc = 26.2; // Replace with actual value
  double isi = 12.3; // Replace with actual value
  double rain = 0.8;

  // Fetch wind speed
  double wind = windspeed;

  // Fetch temp and rh values from Realtime Database
  double temp = temperature;
  double rh = humidity;

  // Prepare input data
  List<double> input = [temp, rh, wind, rain, ffmc, dmc, isi];

  // Run inference on the model
  // Convert input data to 2D array with shape (1, 7)
  var inputArray = List.filled(1, List.filled(7, 0.0));
  for (int i = 0; i < 7; i++) {
    inputArray[0][i] = input[i];
  }

  // Run inference on the model
  List<List<double>> outputList = List.filled(1, List.filled(1, 0.0));
  interpreter.run(inputArray, outputList);

  // Process output to obtain predictions
  double output = outputList[0][0];
  return output;
}

Future<int> runCLSModel(
double temperature, double humidity, double windspeed) async {
  final interpreter =
  await Interpreter.fromAsset('assets/models/model_fwi.tflite');

  // Hardcoded values
  double ffmc = 85.4; // Replace with actual value
  double dmc = 16.0; // Replace with actual value
  double isi = 4.5; // Replace with actual value
  double rain = 0.0;

  // Fetch wind speed
  double wind = 14;

  // Fetch temp and rh values from Realtime Database
  double temp = temperature;
  double rh = humidity;

  // Prepare input data
  List<double> input = [temp, rh, wind, rain, ffmc, dmc, isi];

  // Run inference on the model
  List<List<double>> outputList = List.filled(1, List.filled(1, 0.0));
  interpreter.run(input, outputList);

  // Process output to obtain predictions
  int output = outputList[0][0].round();
  return output;
}
