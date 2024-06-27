import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../utils/animations/login_page_animations.dart';
import '../utils/page_routes/slide_page_route.dart';

class AnimatedHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimatedHomePageState();
  }
}

class _AnimatedHomePageState extends State<AnimatedHomePage>
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
    return _HomePage(_controller);
  }
}

class _HomePage extends StatelessWidget {

  late double _deviceHeight;
  late double _deviceWidth;

  Color _primaryColor = Color.fromRGBO(15, 17, 26, 1.0);
  Color _secondaryColor = Color.fromRGBO(85, 255, 226, 1.0);
  Color _bgmColor = Color.fromRGBO(51, 51, 51, 1.0);

  final AnimationController _controller;
  late final EnterAnimation _animation;

  _HomePage(this._controller){
    _animation = EnterAnimation(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _bgmColor,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: _deviceWidth,
          height: _deviceHeight * 0.60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _avatarWidget(context),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03),
              _nameWidget(),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20),
              _logoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarWidget(context) {
    double _circleD = MediaQuery.of(context).size.height * 0.25;
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
                borderRadius: BorderRadius.circular(200),
                border: Border.all(color: _secondaryColor, width: 1.5),
                image: DecorationImage(
                  image: AssetImage('assets/images/User_Avatar.png',),
                ),
              ),
            ),
          );
        },
    );
  }

  Widget _nameWidget(){
    return Container(
      child: Text(
        "Thank You !!!",
        style: TextStyle(
          color: _secondaryColor,
          fontSize: 34,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _logoutButton(BuildContext context){
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width * 0.38,
      height: MediaQuery.of(context).size.height * 0.055,
      color: _secondaryColor,
      child: Text("LOG OUT",
        style: TextStyle(
            fontSize: 16,
            color: _bgmColor,
            fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: BorderSide(color: Colors.black, width: 1)
      ),
      onPressed: (){
        Navigator.pushReplacement(context,
          SlidePageRoute(AnimatedLoginPage(),
          ),
        );},
    );
  }
}