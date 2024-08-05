import 'package:flutter/material.dart';
import 'package:leos_drinking_game/models/user_model.dart';

class WhoDrankButton extends StatelessWidget {
  final UserModel user;
  final bool isSelected;
  final Function() onTap;

  const WhoDrankButton(
      {super.key,
      required this.user,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1.1,
                blurRadius: 5,
                offset: const Offset(0, 1),
              )
            ],
            border: Border.all(
              color: isSelected
                  ? Colors.orangeAccent.shade100
                  : Colors.grey.shade300,
              width: 1,
            ),
            gradient: isSelected
                ? const LinearGradient(
                    colors: [
                      Color(0xFFf6d5f7),
                      Color(0xFFfbe9d7),
                    ],
                  )
                : null,
          ),
          child: Row(
            children: [
              Image.asset(
                user.imoji,
                width: 25,
                height: 25,
              ),
              const SizedBox(width: 10),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 14,
                    color: isSelected ? Colors.greenAccent : Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
