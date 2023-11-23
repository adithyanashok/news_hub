import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoppinsText extends StatelessWidget {
  const PoppinsText({
    Key? key,
    required this.text,
    this.maxLines,
    this.textOverflow,
    this.fontSize = 13,
    this.fontWeight = FontWeight.w600,
    this.color = Colors.black,
  }) : super(key: key);

  final String text;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: textOverflow,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
