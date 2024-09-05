
import 'package:chatapp/Widgets/constant.dart';
import 'package:chatapp/models/Massege.dart';
import 'package:flutter/material.dart';

class Chat_Bubble extends StatelessWidget {
  const Chat_Bubble({
    super.key, required this.massege,
  });
final Massege massege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          color: KprimaryColor,
        ),
        child:  Padding(
          padding:const EdgeInsets.all(10),
          child: Text(
            massege.massege,
            style:const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class Chat_BubbleForFriend extends StatelessWidget {
  const Chat_BubbleForFriend({
    super.key, required this.massege,
  });
final Massege massege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration:const BoxDecoration(
          borderRadius:  BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
          color: Colors.blue,
        ),
        child:  Padding(
          padding:const EdgeInsets.all(10),
          child: Text(
            massege.massege,
            style:const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}



