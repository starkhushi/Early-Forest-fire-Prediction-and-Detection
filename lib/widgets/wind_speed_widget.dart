import 'dart:async';
import 'package:flutter/material.dart';

import '../methods/get_wind_speed.dart';

class WindSpeedWidget extends StatefulWidget {
  @override
  _WindSpeedWidgetState createState() => _WindSpeedWidgetState();
}

class _WindSpeedWidgetState extends State<WindSpeedWidget> {
  Timer? _timer;
  Future<double>? _windSpeedFuture;

  @override
  void initState() {
    super.initState();
    _windSpeedFuture = fetchWindSpeed();
    _timer = Timer.periodic(const Duration(minutes: 10), (Timer t) {
      setState(() {
        _windSpeedFuture = fetchWindSpeed();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: _windSpeedFuture,
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('Wind Speed: ${snapshot.data} mph');
        }
      },
    );
  }
}