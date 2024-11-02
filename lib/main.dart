import 'package:challange_beclever/core/config/bloc/bloc_providers.dart';
import 'package:challange_beclever/core/config/bloc/service_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();
  // Wait for all async dependencies to be ready
  await sl.allReady();
  runApp(const BlocProviders());
}
