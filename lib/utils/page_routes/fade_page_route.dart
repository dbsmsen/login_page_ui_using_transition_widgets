import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder{
  final Widget _child;

  FadePageRoute(this._child): super(
    transitionDuration: Duration(milliseconds: 500),
    transitionsBuilder: (BuildContext _context,
        Animation<double> animation,
        Animation<double> SecondAnimation,
        Widget child){
      return FadeTransition(
        child: child,
        opacity: animation,
      );
    },
    pageBuilder: (BuildContext _context, animation, secondAnimation){
      return _child;
    },
  );
}