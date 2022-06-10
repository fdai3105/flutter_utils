import 'package:flutter/cupertino.dart';

class Navigation {
  const Navigation._();

  static Future push(BuildContext context, Widget page) async {
    final route = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
    return Navigator.of(context).push(route);
  }

  static Future pop<T extends Object?>(BuildContext context, T data) async {
    if (Navigator.canPop(context)) return Navigator.pop(context, data);
  }
}
