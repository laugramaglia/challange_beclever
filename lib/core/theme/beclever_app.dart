import 'package:challange_beclever/features/auth/presentation/ui/pages/new_user_page.dart';
import 'package:flutter/material.dart';

class BecleverApp extends StatelessWidget {
  const BecleverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beclever challange',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const NewUserPage(),
    );
  }
}
