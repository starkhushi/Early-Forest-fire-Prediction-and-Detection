import 'package:flutter/material.dart';

class Log extends StatelessWidget {
  const Log({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.list_alt,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24.0,
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                  child: Text(
                    'Log Entry 1',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontFamily: 'Readex Pro',
                          color: Theme.of(context).colorScheme.onPrimary,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                  child: Text(
                    'Error',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: 'Readex Pro',
                          color: Theme.of(context).colorScheme.error,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Text(
                  '23m ago',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontFamily: 'Readex Pro',
                        color: Theme.of(context).colorScheme.onSecondary,
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
