import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget _child;

  SlidePageRoute(this._child)
    : super(
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder:
            (
              BuildContext context,
              Animation animation,
              Animation secondAnimation,
              Widget child,
            ) {
              animation = Tween<Offset>(
                begin: Offset(1, 0),
                end: Offset(0, 0),
              ).animate(animation as Animation<double>);
              return SlideTransition(
                position: animation as Animation<Offset>,
                child: child,
              );
            },
        pageBuilder: (BuildContext context, animation, secondAnimation) {
          return _child;
        },
      );
}
