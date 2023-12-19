import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../component/bottom.dart';
import '../component/textFormField.dart';
import '../helper/showSnakBar.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;
  String? password;
  bool isLoading=false;
  bool view=false;

  GlobalKey<FormState> formKey=GlobalKey();

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
                        "Regester",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          prefixIcon: Icon(Icons.email_outlined),
                        obscureText: false,
                        validator: (String? value) {
                            if (value!.isEmpty) {
                              return "value is empty";
                            }
                          },
                          onChanged: (data) {
                            email = data;
                          },
                          labelText: "Email"),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        obscureText:view? false: true,
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(onPressed: () {
                            setState(() {
                              view=!view;
                            });
                          },
                            icon: Icon(view?Icons.code_off : Icons.remove_red_eye_outlined),),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "value is empty";
                            }
                          },
                          onChanged: (data) {
                            password = data;
                          },
                          labelText: "Password"),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomBottom(
                          onTap: () async {
                            if(formKey.currentState!.validate()){
                              isLoading=true;
                              setState(() {

                              });
                            try {
                              await registerUser();
                              showSnakBar(context, "sucsess");
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == "weak-password") {
                                print("the password is too weak");
                                showSnakBar(context,"password is too weak");
                              } else if (e.code == "email-already-in-use") {
                                showSnakBar(context, "this account is already exist");
                              }
                            }
                            isLoading=false;
                            setState(() {

                            });
                          }else{

                            }
                            },
                          bottomName: "Register",
                          bottomColor: Colors.white),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Sign in",
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

  Future<void> registerUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    print(userCredential.user!.email);
  }
}
