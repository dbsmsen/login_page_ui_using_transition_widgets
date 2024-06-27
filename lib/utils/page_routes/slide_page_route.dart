import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder{
  final Widget _child;

  SlidePageRoute(this._child): super(
    transitionDuration: Duration(milliseconds: 500),
    transitionsBuilder: (BuildContext _context,
        Animation<double> animation,
        Animation<double> secondAnimation,
        Widget child){

      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        child: child,
        position: offsetAnimation,
      );
    },
    pageBuilder: (BuildContext _context, animation, secondAnimation){
      return _child;
    },
  );
}