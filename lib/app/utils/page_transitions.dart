import 'package:flutter/material.dart';

/// A custom page route that provides a smooth combined slide-and-fade transition,
/// elevating the navigation feel of the application.
class AnimatedPageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;

  AnimatedPageRoute({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: const Duration(milliseconds: 250),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide slightly from right towards center (6% offset)
            const begin = Offset(0.06, 0.0);
            const end = Offset.zero;
            final curveTween = CurveTween(curve: Curves.easeOutCubic);
            final tween = Tween(begin: begin, end: end).chain(curveTween);
            
            final slideAnimation = animation.drive(tween);
            final fadeAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            );

            return SlideTransition(
              position: slideAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            );
          },
        );
}
