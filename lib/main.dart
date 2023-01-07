import 'package:flutter/material.dart';
import 'package:projectmanger/screens/login.dart';
import 'package:provider/provider.dart';
import 'models/data.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
    create: (context) => logindata(),
    child: const MyApp())
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage()
    );
  }
}

