import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:forest_fire/screens/trac_location.dart';

import '../methods/get_wind_speed.dart';
import '../methods/model_predictor.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
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
            Map<dynamic, dynamic> values = snapshot.data!.snapshot.value as Map<
                dynamic,
                dynamic>;
            double temp = values['DHT_11']['Temperature'];
            double rh = (values['DHT_11']['Humidity']).toDouble();
            int flame = values['Flame_Sensor']['Infrared_Value'];
            print("The answer ${runFWIModel(temp, rh, wind)}");
            // Run your model with the new data
            runModel(temp, rh, wind).then((output) {
              if (flame==45) {

                // If the model returns 1, show an AlertDialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Alert'),
                      content: Text('Your forest is safe.'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
              else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      iconPadding: EdgeInsets.all(20),
                      iconColor: Colors.red,
                      icon: Icon(
                          Icons.warning,
                        size: 120,
                      ),
                      title: Text('Alert'),
                      content: Text('Fire Detected. Immediate action required'),
                      actions: [
                        Center(
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),

                            ),
                            child: Text(
                                'Track Fire',
                              style: TextStyle(
                                color: Colors.white,
                              )
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TracLocationScreen()
                                )
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            });
          }
            // Return your widget here
            return Container();
          } else {
            return Center(child: CircularProgressIndicator());
          }
      },
    );
  }
}