import 'package:flutter/material.dart';
import 'posts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al-Quran Nur Karim',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostPage(),
    );
  }
}
