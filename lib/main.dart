import 'package:flutter/material.dart';
import 'screens/event_screen.dart';

void main() {
  runApp(const OnlyBeesApp());
}

class OnlyBeesApp extends StatelessWidget {
  const OnlyBeesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnlyBees Clone',
      theme: ThemeData.dark(),
      home: const EventScreen(),
    );
  }
}
