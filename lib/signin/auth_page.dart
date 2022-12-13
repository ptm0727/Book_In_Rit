import 'package:dbsproject/signin/signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:dbsproject/signin/loginwidget.dart';
class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin=true;
  @override
  Widget build(BuildContext context) {
    return isLogin
        ?Signin(onClickedSignup: toggle,):
    SignUpWidget(onClickedSignIn: toggle);
  }
  void toggle()=>setState(() =>isLogin=!isLogin);

}