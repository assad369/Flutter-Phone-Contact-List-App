import 'package:assignment14/theme.dart';
import 'package:assignment14/ui/contact_list_screen.dart';
import 'package:flutter/material.dart';

class ContactListApp extends StatelessWidget {
  const ContactListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const ContactListScreen(),
    );
  }
}
