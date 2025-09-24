import 'package:flutter/material.dart';

class CustomElvButt extends StatelessWidget {
  const CustomElvButt({super.key, required this.onPressed, required this.text});
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.065,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(
            text,
          )),
    );
  }
}