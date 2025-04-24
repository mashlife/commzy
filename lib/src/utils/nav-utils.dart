import 'package:flutter/material.dart';

class NavUtils {
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navKey => _navigatorKey;

  static nextScreen(Widget widget, {Function? callback}) {
    _navigatorKey.currentState!.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration(milliseconds: 350),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.easeOutCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return FadeTransition(opacity: animation.drive(tween), child: child);
        },
      ),
    );
  }

  static removeAllAndOpen(Widget widget) {
    _navigatorKey.currentState!.pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration(milliseconds: 350),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.easeOutCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return ScaleTransition(scale: animation.drive(tween), child: child);
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  static remove({dynamic value}) {
    _navigatorKey.currentState!.pop(value ?? false);
  }
}
