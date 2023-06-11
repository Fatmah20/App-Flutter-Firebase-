
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
   CustomButton({
   required this.text ,this.onTap
  });

  String? text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        margin:
        const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.purple[700]),
        child:  Center(
          child: Text( text!,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
