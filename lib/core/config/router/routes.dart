import 'package:challange_beclever/features/auth/presentation/ui/pages/lander_page.dart';
import 'package:challange_beclever/features/auth/presentation/ui/pages/login_page.dart';
import 'package:challange_beclever/features/auth/presentation/ui/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(path: '/', routes: [
  // Onboarding routes
  TypedGoRoute<LanderRoute>(
    path: 'lander',
    routes: [
      TypedGoRoute<LoginRoute>(path: 'login'),
      TypedGoRoute<RegisterRoute>(path: 'register'),
    ],
  ),
])

// Home
@immutable
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Scaffold();
  }
}

// Auth

@immutable
class LanderRoute extends GoRouteData {
  const LanderRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LanderPage();
  }
}

@immutable
class RegisterRoute extends GoRouteData {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegisterPage();
  }
}

@immutable
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}
