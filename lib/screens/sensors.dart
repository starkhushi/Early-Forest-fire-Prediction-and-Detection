import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:forest_fire/widgets/wind_speed_widget.dart';

class SensorsScreen extends StatefulWidget {
  const SensorsScreen({super.key});

  @override
  State<SensorsScreen> createState() => _SensorsScreenState();
}

class _SensorsScreenState extends State<SensorsScreen> {
  final database = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 16.0),
              child: Text(
                'All Sensors',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontFamily: 'Outfit',
                  letterSpacing: 0.0,
                ),
              ),
            ),
            Expanded(
                child: StreamBuilder(
                  stream: database.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.snapshot.value is Map<dynamic, dynamic>) {
                        Map<dynamic, dynamic> values = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                        List<Widget> sensorWidgets = [];
                        values.forEach((sensor, readings) {
                          if (readings is Map) {
                            String sensorName = sensor.toString().replaceAll('_', ' ');
                            List<Widget> readingWidgets = [];
                            readings.forEach((key, value) {
                              String readingName = key.toString().replaceAll('_', ' ');
                              readingWidgets.add(
                                Text(
                                  '$readingName: $value',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              );
                            });
                            sensorWidgets.add(
                              // ListTile(
                              //   title: Text(
                              //     sensorName,
                              //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              //       fontFamily: 'Readex Pro',
                              //       letterSpacing: 0.0,
                              //     ),
                              //   ),
                              //   subtitle: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: readingWidgets,
                              //   ),
                              // ),
                              Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          sensorName,
                                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: readingWidgets,
                                    ),
                                  ],
                                  )
                                ),
                            );
                            sensorWidgets.add(WindSpeedWidget());
                          }
                        });
                        return ListView(
                          children: sensorWidgets,
                        );
                      } else {
                        // Handle the case where value is not a Map
                        return Center(child: Text('Error: Data is not a Map'));
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
            ),
          ]
        )
      ),
    );
  }
}
