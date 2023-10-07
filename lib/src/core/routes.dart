import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  // A global key for the NavigatorState
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // A global key for the ScaffoldMessengerState
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // Static method to get the widget for a given name
  static Widget getWidget(String? name) {
    switch (name) {
      default:
        throw UnimplementedError();
    }
  }

  // Static method to get the Pages for a given settings
  static Route<T> pages<T>(RouteSettings settings) {
    return getRoute(getWidget(settings.name), settings: settings);
  }

  // Static method to get the Route for a given widget and settings
  static Route<T> getRoute<T>(Widget widget,
      {RouteSettings? settings, String? name}) {
    settings ??= RouteSettings(name: name);
    return CupertinoPageRoute(
      settings: settings,
      builder: (context) => widget,
    );
  }

  // Static method to push a new page onto the navigation stack
  static Future<T?>? push<T extends Object?>({Widget? page, String? name}) {
    assert(page != null || name != null);
    page ??= getWidget(name);
    return navigatorKey.currentState?.push<T>(getRoute(page, name: name));
  }

  // Static method to push a new page onto the navigation stack and replace
  // the current page
  static Future<T?>? pushReplacement<T extends Object?, TO extends Object>(
          Widget page,
          {String? name,
          TO? result}) =>
      navigatorKey.currentState
          ?.pushReplacement<T, TO>(getRoute(page, name: name), result: result);

  // Static method to push a new page onto the navigation stack and remove
  // all pages until the predicate returns true
  static Future<T?>? pushAndRemoveUntil<T extends Object?, TO extends Object>({
    String? name,
    Widget? page,
    bool Function(Route<dynamic>)? predicate,
  }) {
    assert(page != null || name != null);
    page ??= getWidget(name);
    predicate = (p0) => false;
    return navigatorKey.currentState
        ?.pushAndRemoveUntil<T>(getRoute(page, name: name), predicate);
  }

  // Static method to pop the current page from the navigation stack
  static void pop<T extends Object?>() => navigatorKey.currentState?.pop<T>();

  // Static method to check if the navigation stack can be popped
  static bool canPop<T extends Object?>() =>
      navigatorKey.currentState?.canPop() ?? false;
}
