import 'dart:async';
import 'package:challange_beclever/features/auth/presentation/ui/pages/finish_register_page.dart';
import 'package:challange_beclever/features/auth/presentation/ui/pages/lander_page.dart';
import 'package:challange_beclever/features/auth/presentation/ui/pages/login_page.dart';
import 'package:challange_beclever/features/auth/presentation/ui/pages/register_page.dart';
import 'package:challange_beclever/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<LanderRoute>(
      path: 'lander',
      routes: [
        TypedGoRoute<LoginRoute>(path: 'login'),
        TypedGoRoute<RegisterRoute>(
          path: 'register',
          routes: [
            TypedGoRoute<FinishRegisterRoute>(path: 'finish'),
          ],
        ),
      ],
    )
  ],
)

// Home
@immutable
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
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

@immutable
class FinishRegisterRoute extends GoRouteData {
  final bool $extra;
  const FinishRegisterRoute({this.$extra = false});

  @override
  CustomTransitionPage<void> buildPage(
      BuildContext context, GoRouterState state) {
    return CustomTransitionPage<void>(
        key: state.pageKey,
        child: FinishRegisterPage(
          isSuccess: $extra,
        ),
        transitionsBuilder: (BuildContext _, Animation<double> animation,
            Animation<double> __, Widget child) {
          return ScaleTransition(scale: animation, child: child);
        });
  }
}
