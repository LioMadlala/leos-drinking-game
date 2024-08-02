import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final double? textSize;
  final Function()? onTap;
  final Widget? widget;
  final double? height;
  final bool isBold;

  const CustomChip(
      {super.key,
      required this.text,
      this.bgColor,
      this.textColor,
      this.onTap,
      this.textSize,
      required this.isBold,
      this.widget,
      this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: height,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.purpleAccent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Row(
            children: [
              widget ?? Container(),
              Text(
                text,
                style: TextStyle(
                  fontSize: textSize ?? 10,
                  color: textColor ?? Colors.white,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
