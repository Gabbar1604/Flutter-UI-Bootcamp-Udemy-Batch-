import 'package:authentifyy/pages/fade_page_route.dart';
import 'package:authentifyy/pages/login_page.dart';
import 'package:authentifyy/pages/user_model.dart';
import 'package:flutter/material.dart';

import './home_page.dart';

class AnimatedLoginPage extends StatefulWidget {
  const AnimatedLoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AnimatedLoginPageState();
  }
}

class _AnimatedLoginPageState extends State<AnimatedLoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LoginPage(
      MediaQuery.of(context).size.height,
      MediaQuery.of(context).size.width,
      _controller,
      EnterAnimation(_controller),
      _nameController,
      _emailController,
    );
  }
}

class _LoginPage extends StatelessWidget {
  double _deviceHeight;
  double _deviceWidth;

  final Color _primaryColor = Color.fromRGBO(125, 191, 211, 1.0);
  final Color _secondaryColor = Color.fromRGBO(169, 224, 241, 1.0);

  final AnimationController _controller;
  EnterAnimation _animation;
  final TextEditingController _nameController;
  final TextEditingController _emailController;

  _LoginPage(
    this._deviceHeight,
    this._deviceWidth,
    this._controller,
    this._animation,
    this._nameController,
    this._emailController,
  ) {
    _animation = EnterAnimation(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _primaryColor,
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: _deviceHeight * 0.65,
          width: _deviceWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _avatarWidget(),
              SizedBox(height: _deviceHeight * 0.05),
              _nameTextField(),
              _emailTextField(),
              _passwordTextField(),
              SizedBox(height: _deviceHeight * 0.10),
              _loginButton(context),
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
              color: _secondaryColor,
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

  Widget _emailTextField() {
    return SizedBox(
      width: _deviceWidth * 0.70,
      child: TextField(
        controller: _emailController,
        cursorColor: Colors.white,
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "John.doe@gmail.com",
          prefixIcon: Icon(Icons.email, color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return SizedBox(
      width: _deviceWidth * 0.70,
      child: TextField(
        obscureText: true,
        cursorColor: Colors.white,
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(Icons.lock, color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return SizedBox(
      width: _deviceWidth * 0.70,
      child: TextField(
        controller: _nameController,
        cursorColor: Colors.white,
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Your Name",
          prefixIcon: Icon(Icons.person, color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return MaterialButton(
      minWidth: _deviceWidth * 0.38,
      height: _deviceHeight * 0.055,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(color: Colors.white),
      ),
      onPressed: () async {
        await _controller.reverse();
        final user = User(
          name: _nameController.text.isEmpty ? "Guest" : _nameController.text,
          email: _emailController.text.isEmpty
              ? "guest@example.com"
              : _emailController.text,
        );
        Navigator.pushReplacement(
          context,
          FadePageRoute(AnimatedHomePage(user: user.name)),
        );
      },
      child: Text(
        "LOG IN",
        style: TextStyle(
          fontSize: 16,
          color: _primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
