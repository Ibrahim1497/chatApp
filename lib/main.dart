import 'package:chat_app/constant.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/chatScreen.dart';
import 'package:chat_app/screens/loginScreen.dart';
import 'package:chat_app/screens/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "LoginScreen":(context)=>LoginScreen(),
        "RegisterScreen":(context)=>RegisterScreen(),
        "ChatScreen":(context)=>ChatScreen(),
      },
      home: LoginScreen(),
    );
  }
}
