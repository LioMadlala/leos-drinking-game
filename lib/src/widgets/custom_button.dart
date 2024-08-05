import 'package:flutter/material.dart';

Widget customButton({
  required String text,
  Function()? onPressed,
  required Color bgColor,
  required Color textColor,
  required double textSize,
  required double height,
}) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(
          double.infinity,
          height,
        ), // Set minimum width to full width
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: textSize,
        ),
      ));
}
