import 'package:challange_beclever/core/config/router/router.dart';
import 'package:challange_beclever/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class BecleverApp extends StatelessWidget {
  const BecleverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Beclever challange',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
