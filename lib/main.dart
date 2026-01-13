import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/ticket_provider.dart';
import 'screens/event_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TicketProvider(), // ❌ REMOVE loadSections()
      child: const OnlyBeesApp(),
    ),
  );
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
