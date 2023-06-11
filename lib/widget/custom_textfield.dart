
import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
   CustomTextField({required this.hintText,this.onChanged,this.obscureText});

String? hintText;
Function(String)? onChanged;
bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey[200]!))),
      child:  TextFormField(
        obscureText: obscureText!,
        validator: (data){
          if(data!.isEmpty){
            return ('Field is Required');
          }
        },
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
            TextStyle(color: Colors.grey),
            border: InputBorder.none),
      ),
    );
  }
}