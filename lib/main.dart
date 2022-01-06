import 'package:flutter/material.dart';
import 'package:pltfrm_chnl_demo/info_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Platform Channel Demo',
      theme: ThemeData.dark(),
      home: const InfoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}