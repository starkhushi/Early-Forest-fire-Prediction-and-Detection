import 'package:flutter/material.dart';
import 'package:forest_fire/widgets/log.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
                      child: Text(
                        'All Logs',
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontFamily: 'Outfit',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 16.0, 16.0, 16.0),
                        child: IconButton(
                          iconSize: 40,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          icon: Icon(
                            Icons.restore_rounded,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 24,
                          ),
                          onPressed: (){},
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                    itemBuilder: (ctx, index) {
                  return const Log();
                }
                )

              )
            ],
          )
      ),
    );
  }
}
