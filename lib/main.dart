
import 'package:flutter/material.dart';
import 'package:ui_login_register_flutter/pages/chat_page.dart';
import 'package:ui_login_register_flutter/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( ScholarApp());
}

class ScholarApp extends StatelessWidget {
  const ScholarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: {
        ChatPage.id :(context)=> ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
