import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:forest_fire/screens/fwi_screen.dart';
import 'package:forest_fire/screens/sensors.dart';
import 'package:forest_fire/widgets/fwi_dialog.dart';
import 'package:forest_fire/widgets/gridcard.dart';

import '../methods/model_predictor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                    child: TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      obscureText: false,
                      decoration: InputDecoration(
                          labelText: "Services",
                          labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFFA5A5A5),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                          hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF696969),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(24)
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(24)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(24)
                          ),
                          prefixIcon: Icon(
                              Icons.search
                          ),
                          suffixIcon: Icon(
                              Icons.mic_none
                          )
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/download_1.png',
                        width: 360,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
                      child: Text(
                        'POPULAR SERVICES',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ),
                  GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1
                    ),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      GridCard(iconData: Icons.fire_truck_outlined, text: "Fire Stations", onPressed: () async {
                        var result = await runFWIModel(90.0, 6.6, 9.2);
                        print("the output is $result");

                      },),
                      GridCard(iconData: Icons.restore_sharp, text: "Logo", onPressed: (){},),
                      GridCard(
                        iconData: Icons.content_paste_outlined,
                        text: "FWI",
                        onPressed:(){ Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FWIDialog()
                          )
                        );}
                        ,),
                      GridCard(iconData: Icons.location_on_outlined, text: "Location Tracker", onPressed: (){},),
                      GridCard(iconData: Icons.keyboard_control_sharp, text: "More",onPressed: (){},),
                    ],
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                      child: Text(
                        'SERVICE CATEGORIES',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.onPrimary,
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const SensorsScreen()
                          )
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/video_1.png',
                          width: 347.0,
                          height: 68.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                    child: InkWell(
                      onTap:  (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const FWIScreen()
                            )
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/fwi_pic.png',
                          width: 347.0,
                          height: 68.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                    child: InkWell(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/camera.png',
                          width: 347.0,
                          height: 68.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}