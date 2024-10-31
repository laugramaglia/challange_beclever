import 'package:challange_beclever/core/config/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

final router = GoRouter(
  navigatorKey: routerKey,
  debugLogDiagnostics: true,
  routes: $appRoutes,
  initialLocation: const LanderRoute().location,
);
