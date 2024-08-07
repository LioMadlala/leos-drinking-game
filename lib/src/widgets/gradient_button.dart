import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  final List<Color> colors;
  final bool isBold;

  const RoundedButtonWidget({
    super.key,
    required this.buttonText,
    this.onPressed,
    required this.colors,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 2), blurRadius: 2.0)
        ],

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 1.0],
          colors: colors,
        ),
        // color: Colors.deepPurple.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            minimumSize: const Size(
              double.infinity,
              50,
            ),
            shadowColor: Colors.transparent),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
