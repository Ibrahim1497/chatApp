
import 'package:chat_app/models/messageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class chatMessageStyle extends StatelessWidget {
   chatMessageStyle({
    super.key,
    required this.message
  });
final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)
            )
        ),
        child: Text(message.message,style: TextStyle(
          color: Colors.white,
          fontSize: 20
        ),),
      ),
    );
  }
}




class chatMessageAther extends StatelessWidget {
  chatMessageAther({
    super.key,
    required this.message
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: CupertinoColors.activeBlue,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)
            )
        ),
        child: Text(message.message,style: TextStyle(
            color: Colors.white,
            fontSize: 20
        ),),
      ),
    );
  }
}
