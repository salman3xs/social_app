import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static Widget getWidget(String? name) {
    switch (name) {
      default:
        throw UnimplementedError();
    }
  }

  static Route<T> pages<T>(RouteSettings settings) {
    return getRoute(getWidget(settings.name), settings: settings);
  }

  static Route<T> getRoute<T>(Widget widget,
      {RouteSettings? settings, String? name}) {
    settings ??= RouteSettings(name: name);
    return CupertinoPageRoute(
      settings: settings,
      builder: (context) => widget,
    );
  }

  static Future<T?>? push<T extends Object?>({Widget? page, String? name}) {
    assert(page != null || name != null);
    page ??= getWidget(name);
    return navigatorKey.currentState?.push<T>(getRoute(page, name: name));
  }

  static Future<T?>? pushReplacement<T extends Object?, TO extends Object>(
          Widget page,
          {String? name,
          TO? result}) =>
      navigatorKey.currentState
          ?.pushReplacement<T, TO>(getRoute(page, name: name), result: result);

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

  static void pop<T extends Object?>() => navigatorKey.currentState?.pop<T>();

  static bool canPop<T extends Object?>() =>
      navigatorKey.currentState?.canPop() ?? false;
}
