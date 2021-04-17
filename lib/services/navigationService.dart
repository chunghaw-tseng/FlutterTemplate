import 'package:flutter/material.dart';

/// Navigation service that routes the user to specific pages depending on the name

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String currentRoute;

  Future<dynamic> navigateTo(String routeName, String current) {
    currentRoute = routeName;
    return navigatorKey.currentState.pushNamed(routeName, arguments: current);
  }

  String getCurrentState() {
    return currentRoute;
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
