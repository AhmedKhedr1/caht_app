import 'package:chatapp/Widgets/Chat_Bubble.dart';
import 'package:chatapp/Widgets/constant.dart';
import 'package:chatapp/models/Massege.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String id = 'ChatScreen';
  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference masseges =
      FirebaseFirestore.instance.collection('masseges');

  @override
  Widget build(BuildContext context) {
    var email=ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: masseges.orderBy('CreatedAt').snapshots(),
      builder: (context, snapshot) {
        snapshot.data;
        if (snapshot.hasData) {
          List<Massege> massegelist = [];
          // ignore: dead_code
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            massegelist.add(Massege.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: KprimaryColor,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(
                      'assets/images/scholar.png',
                    ),
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'Chat',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: massegelist.length,
                    itemBuilder: (context, index) {
                      return massegelist[index].id==email? Chat_Bubble(massege: massegelist[index],
                      ):Chat_BubbleForFriend(massege: massegelist[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      masseges.add({
                        'massege': value,
                        'CreatedAt': DateTime.now(),
                        'id':email,
                      });
                      controller.clear();
                      _controller.animateTo(
                          _controller.position.maxScrollExtent,
                          duration: Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn);
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            child: Icon(Icons.send, color: KprimaryColor)),
                        hintText: 'Enter Your Massege',
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16)))),
                  ),
                )
              ],
            ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}
