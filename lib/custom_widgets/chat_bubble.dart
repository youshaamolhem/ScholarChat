import 'package:flutter/material.dart';
import 'package:scholar_chat2/Models/message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    @required this.message,
  });
  final MessagesModel? message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )),
        child: Text(message!.message),
      ),
    );
  }
}

class ChatBubbleRecieve extends StatelessWidget {
  const ChatBubbleRecieve({
    @required this.message,
  });
  final MessagesModel? message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            )),
        child: Text(message!.message),
      ),
    );
  }
}
