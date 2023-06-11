import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_login_register_flutter/pages/register_page.dart';

import '../helpers/show_snak_bar.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';
import 'chat_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  static String id ='LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                              "Login",
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
                                          hintText: "Email or Phone number",
                                          onChanged: (data) {
                                            email = data;
                                          },
                                        ),
                                        CustomTextField(
                                          obscureText: true,
                                          hintText: "Password ",
                                          onChanged: (data) {
                                            password = data;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                CustomButton(
                                  text: "Login",
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      isLoading = true;
                                      setState(() {});
                                      try {
                                        await LoginUser();

                                         Navigator.pushNamed(context, ChatPage.id,arguments: email);
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          ShowSnackBar(context,
                                              'No user found for that email.');
                                        } else if (e.code == 'wrong-password') {
                                          ShowSnackBar(context,
                                              'Wrong password provided for that user.');
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
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return RegisterPage();
                                          }));
                                        },
                                        child: const Text(
                                          "Register  ",
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

  Future<void> LoginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
