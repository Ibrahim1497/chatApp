import 'package:chat_app/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../component/chatStyle.dart';
import '../models/messageModel.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(messagingCollection);
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String email= ModalRoute.of(context)?.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(createdAt,descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: primaryColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(logo),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Chat"),
                    ],
                  ),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: scrollController,
                        itemCount: messagesList.length,
                        itemBuilder: (context, i) {
                           return messagesList[i].id==email ? chatMessageStyle(
                            message: messagesList[i],
                          ):chatMessageAther(message: messagesList[i]);
                        }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: controller,
                        onFieldSubmitted: (val) {
                          messages
                              .add({"message": val,
                            createdAt: DateTime.now(),
                            "id":email
                          });
                          controller.clear();
                          scrollController.animateTo(
                              0,
                              duration: Duration(seconds: 1),
                              curve: Curves.bounceInOut);
                        },
                        decoration: InputDecoration(
                            hintText: "send message",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: primaryColor)),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.send,
                                color: primaryColor,
                              ),
                            )),
                      ),
                    )
                  ],
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
