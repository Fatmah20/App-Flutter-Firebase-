import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/message.dart';
class ChatBubble extends StatelessWidget {
   ChatBubble({
  required this.message

  });


  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(17),
        decoration: BoxDecoration(
            color: Colors.purple[700],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({
    required this.message
  });

  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(17),
        decoration: BoxDecoration(
            color: Colors.yellow[900],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            )),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}