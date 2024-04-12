import 'package:apple/common/component/custom_text_field.dart';
import 'package:apple/common/const/colors.dart';
import 'package:apple/user/view/login_screen.dart';
import 'package:apple/user/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _App(),);
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}

