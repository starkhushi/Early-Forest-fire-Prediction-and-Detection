import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:forest_fire/methods/model_predictor.dart';

import '../methods/get_wind_speed.dart';

class FWIDialog extends StatefulWidget {
  const FWIDialog({Key? key}) : super(key: key);

  @override
  State<FWIDialog> createState() => _FWIDialogState();
}

class _FWIDialogState extends State<FWIDialog> {
  final dbRef = FirebaseDatabase.instance.ref();

  Timer? _timer;

  double wind = 0.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 10), (Timer t) async {
      wind = await fetchWindSpeed();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: dbRef.onValue,
      builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.snapshot.value is Map<dynamic, dynamic>) {
            Map<dynamic, dynamic> values = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            double temp = values['DHT_11']['Temperature'];
            double rh = double.parse(values['DHT_11']['Humidity'].toString());
            return FutureBuilder<double>(
              future: runFWIModel(temp, rh, wind),
              builder: (BuildContext context, AsyncSnapshot<double> fwiSnapshot) {
                if (fwiSnapshot.connectionState == ConnectionState.waiting) {
                  return AlertDialog(
                    title: Text('Processing'),
                    content: CircularProgressIndicator(),
                  );
                } else if (fwiSnapshot.hasError) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('Failed to fetch FWI: ${fwiSnapshot.error}'),
                  );
                } else {
                  return AlertDialog(
                    title: Text('FWI Output'),
                    content: Text('The output of the FWI model is ${fwiSnapshot.data}'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
              },
            );
          } else {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Data is not in the correct format.'),
            );
          }
        } else {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No data available.'),
          );
        }
      },
    );
  }
}