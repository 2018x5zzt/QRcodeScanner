import 'package:flutter/material.dart';
import 'package:qr_code_demo/uipage/rootpage.dart';


void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      title: 'QRcodeScanner',
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}


