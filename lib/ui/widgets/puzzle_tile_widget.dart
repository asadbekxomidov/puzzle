import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TileWidget extends StatelessWidget {
  final int tileValue;
  final VoidCallback onTap;
  final String colorScheme;

  const TileWidget({
    Key? key,
    required this.tileValue,
    required this.onTap,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color tileColor = tileValue == 0
        ? Colors.teal
        : (colorScheme == 'default' ? Colors.green : Colors.blue);

    Color shadowColor = Colors.black.withOpacity(0.5);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          tileValue == 0 ? '' : '$tileValue',
          style: GoogleFonts.daiBannaSil(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
