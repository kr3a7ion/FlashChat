// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ReuseableButton extends StatelessWidget {
  final Color myColor;
  final Function()? onTap;
  final String buttonText;

  const ReuseableButton({
    required this.myColor,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: myColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          
          onPressed: onTap,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonText, style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
