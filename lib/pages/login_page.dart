import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/home_page.dart';
import '../utils/animations/login_page_animations.dart';
import '../utils/page_routes/fade_page_route.dart';

class AnimatedLoginPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _AnimatedLoginPageState();
  }
}

class _AnimatedLoginPageState extends State<AnimatedLoginPage>
    with SingleTickerProviderStateMixin{
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LoginPage(_controller);
  }
}

class _LoginPage extends StatelessWidget{

  Color _primaryColor =Color.fromRGBO(85, 255, 226, 1.0);
  Color _secondaryColor = Color.fromRGBO(15, 17, 26, 1.0);
  Color _bgmColor = Color.fromRGBO(51, 51, 51, 1.0);

  final AnimationController _controller;
  late final EnterAnimation _animation;

  _LoginPage(this._controller){
    _animation = EnterAnimation(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: _primaryColor,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          height: _deviceHeight * 0.60,
          width: _deviceWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _avatarWidget(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08),
              _emailTextField(context),
              _passwordTextField(context),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10),
              _loginButton(context),
            ],
          ),
        ),
      ),
    );
  }

    Widget _avatarWidget(context){
    double _circleD =  MediaQuery.of(context).size.height * 0.25;
    return AnimatedBuilder(
        animation: _animation.controller,
        builder: (BuildContext _context, Widget? _widget){
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.diagonal3Values(
                _animation.circleSize.value, _animation.circleSize.value, 1),
            child: Container(
              height: _circleD,
              width: _circleD,
              decoration: BoxDecoration(
                color: _secondaryColor,
                borderRadius: BorderRadius.circular(200),
                border: Border.all(color: Colors.white, width: 1.5),
                image: DecorationImage(
                  image: AssetImage('assets/images/User_Avatar.png',
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _emailTextField(context){
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: TextField(
        cursorColor: Colors.black38,
        autocorrect: false,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          hintText: "Enter your email here...",
          hintStyle: TextStyle(color: Colors.black38),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _passwordTextField(context){
    bool _obscureText = true;
  return StatefulBuilder(
      builder: (context, setState)
  {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: TextField(
        obscureText: _obscureText,
        cursorColor: Colors.black38,
        autocorrect: false,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          hintText: "Enter your password here...",
          hintStyle: TextStyle(color: Colors.black38),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: _bgmColor,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText; // Toggle password visibility
                });
              }),
        ),
      ),
    );
  },);
  }

  Widget _loginButton(BuildContext _context){
    return MaterialButton(
      minWidth: MediaQuery.of(_context).size.width * 0.38,
      height: MediaQuery.of(_context).size.height * 0.055,
        color: _bgmColor,
        child: Text("LOG IN",
        style: TextStyle(
          fontSize: 16,
          color: _primaryColor,
          fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: BorderSide(color: Colors.white, width: 1)
        ),
        onPressed: () async {
        await _controller.reverse();
        Navigator.pushReplacement(_context,
          FadePageRoute(
            AnimatedHomePage(),
          ),
        );},
    );
  }
}