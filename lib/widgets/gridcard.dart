import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  const GridCard({super.key, required this.iconData, required this.text, required this.onPressed});
  final IconData iconData;
  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color(0xFFE9F5F7),
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      child: InkWell(
        onTap: onPressed,
        splashColor: Theme.of(context).colorScheme.onPrimary,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: (){},
              icon: Icon(
                iconData,
                color: Color(0xFF03045E),
                size: 40,
              ),
              iconSize: 72,
              color: const Color(0xFFE9F5F7),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 1),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    0.0, 10.0, 0.0, 2.0),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontFamily: 'Roboto',
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.clip,
                  ),
                  maxLines: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
