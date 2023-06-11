import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.purple[900]!,
                Colors.purple[300]!,
                Colors.purple[100]!
              ])),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Welcome Back",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ]),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60))),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(
                                  height: 90,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color:
                                                Color.fromRGBO(225, 95, 27, .3),
                                            blurRadius: 20,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: <Widget>[
                                        CustomTextField(
                                          obscureText: false,
                                          onChanged: (data) {
                                            email = data;
                                          },
                                          hintText: "Email or Phone number",
                                        ),
                                        CustomTextField(
                                          obscureText: true,
                                          onChanged: (data) {
                                            password = data;
                                          },
                                          hintText: "Password ",
                                        ),
                                        CustomTextField(
                                          obscureText: true,
                                          hintText: "Confirm Password",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                CustomButton(
                                  text: "Register",
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      isLoading = true;
                                      setState(() {});
                                      try {
                                        await registerUser();
                                        Navigator.pushNamed(context, ChatPage.id) ;
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          ShowSnackBar(context,
                                              'The password provided is too weak.');
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          ShowSnackBar(context,
                                              'The account already exists for that email.');
                                        }
                                      } catch (e) {
                                        print(e.toString());
                                      }
                                      isLoading = false;
                                      setState(() {});
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account  ? ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          " Login  ",
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]))),
    );
  }

  void ShowSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
