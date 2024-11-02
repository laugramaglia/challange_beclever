import 'dart:async';

import 'package:challange_beclever/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:challange_beclever/core/config/bloc/service_locator.dart';
import 'package:challange_beclever/core/config/router/routes.dart';

final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

final router = GoRouter(
  navigatorKey: routerKey,
  debugLogDiagnostics: true,
  routes: $appRoutes,
  initialLocation: const LanderRoute().location,
  refreshListenable: StreamToListenable([sl<AuthenticationBloc>().stream]),
  //The top-level callback allows the app to redirect to a new location.
  redirect: (context, state) {
    final isUnAuthenticated = sl<AuthenticationBloc>().state is! AuthSuccess;
    final landerPath = const LanderRoute().location;

    // Redirect to the login page if the user is not authenticated, and if authenticated, do not show the login page
    if (isUnAuthenticated && !state.matchedLocation.contains(landerPath)) {
      return landerPath;
    }

    return null;
  },
);

class StreamToListenable extends ChangeNotifier {
  late final List<StreamSubscription> subscriptions;

  StreamToListenable(List<Stream> streams) {
    subscriptions = [];
    for (var e in streams) {
      var s = e.asBroadcastStream().listen(_tt);
      subscriptions.add(s);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (var e in subscriptions) {
      e.cancel();
    }
    super.dispose();
  }

  void _tt(event) => notifyListeners();
}
