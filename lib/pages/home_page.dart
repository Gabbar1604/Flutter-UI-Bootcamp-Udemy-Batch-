import 'package:authentifyy/pages/login_page_animations.dart';
import 'package:authentifyy/pages/slide_page_route.dart';
import 'package:authentifyy/pages/user_model.dart';
import 'package:flutter/material.dart';

import './login_page.dart';

class AnimatedHomePage extends StatefulWidget {
  final String user;

  const AnimatedHomePage({super.key, required this.user});

  @override
  State<StatefulWidget> createState() {
    return _AnimatedHomePageState();
  }
}

class _AnimatedHomePageState extends State<AnimatedHomePage>
    with SingleTickerProviderStateMixin {
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
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _HomePage(_controller, User(name: widget.user, email: widget.user));
  }
}

class _HomePage extends StatelessWidget {
  late double _deviceHeight;
  late double _deviceWidth;

  final Color _primaryColor = Color.fromRGBO(169, 224, 241, 1.0);

  final AnimationController _controller;
  late EnterAnimation _animation;
  final User user;

  _HomePage(this._controller, this.user) {
    _animation = EnterAnimation(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: _deviceHeight * 0.70,
          width: _deviceWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _avatarWidget(),
              SizedBox(height: 60),
              _nameWidget(),
              SizedBox(height: 60),
              _logoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarWidget() {
    double circleD = _deviceHeight * 0.25;
    return AnimatedBuilder(
      animation: _animation.controller,
      builder: (BuildContext context, Widget? widget) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
            _animation.circleSize.value,
            _animation.circleSize.value,
            1,
          ),
          child: Container(
            height: circleD,
            width: circleD,
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(500),
              image: DecorationImage(
                image: NetworkImage(
                  "https://imgs.search.brave.com/fLY8WxdhGbi0N0RthqewaSXz0OuklHHcW8IjFbkIKG8/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/dmVjdG9yc3RvY2su/Y29tL2kvcHJldmll/dy0xeC8xNy82MS9t/YWxlLWF2YXRhci1w/cm9maWxlLXBpY3R1/cmUtdmVjdG9yLTEw/MjExNzYxLmpwZw",
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _nameWidget() {
    return Container(
      child: Text(
        user.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _primaryColor,
          fontSize: 35,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return MaterialButton(
      minWidth: _deviceWidth * 0.38,
      height: _deviceHeight * 0.055,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(color: _primaryColor, width: 3),
      ),
      onPressed: () {
        Navigator.push(context, SlidePageRoute(AnimatedLoginPage()));
      },
      child: Text(
        "LOG OUT",
        style: TextStyle(
          fontSize: 16,
          color: _primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
