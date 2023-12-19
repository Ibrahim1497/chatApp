import 'package:chat_app/component/bottom.dart';
import 'package:chat_app/component/textFormField.dart';
import 'package:chat_app/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/showSnakBar.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  bool isLoading = false;

  bool view=false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage(
                            logo),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Chat App",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign in",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        prefixIcon: Icon(Icons.email_outlined),
                        obscureText: false,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "value is empty";
                            }
                          },
                          onChanged: (val) {
                            email = val;
                          },
                          labelText: "Email"),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            view=!view;
                          });
                        },
                          icon: Icon(view?Icons.code_off : Icons.remove_red_eye_outlined),),
                          obscureText:view? false: true,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "value is empty";
                            }
                          },
                          onChanged: (val) {
                            password = val;
                          },
                          labelText: "Password"),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomBottom(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                await loginUser();
                                showSnakBar(context, "sucsess");
                                Navigator.pushReplacementNamed(context, "ChatScreen",arguments: email);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == "user-not-found") {
                                  showSnakBar(context, "user not found");
                                } else if (e.code == "wrong-password") {
                                  showSnakBar(context, "wrong password");
                                }
                              }
                              isLoading = false;
                              setState(() {});
                            }
                          },
                          bottomName: "Sign in",
                          bottomColor: Colors.white),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "RegisterScreen");
                              },
                              child: const Text(
                                "Regester",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    print(userCredential.user!.email);
  }
}
