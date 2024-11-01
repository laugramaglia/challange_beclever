import 'package:challange_beclever/core/config/bloc/bloc_providers.dart';
import 'package:challange_beclever/core/config/bloc/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();
  runApp(const BlocProviders());
}
