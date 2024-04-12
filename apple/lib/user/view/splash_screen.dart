import 'package:apple/common/const/colors.dart';
import 'package:apple/common/const/data.dart';
import 'package:apple/common/layout/default_layout.dart';
import 'package:apple/common/view/root_tab.dart';
import 'package:apple/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: REFREAH_TOKEN_KEY);

    if (accessToken == null || refreshToken == null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginScreen(),),);
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RootTab(),),);
    }
  }

  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
      backgoundColor: PRIMARY_COLOR,
        child : SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('asset/img/logo/logo.png', width: MediaQuery.of(context).size.width / 2,),
              const SizedBox(height: 16.0,),
              CircularProgressIndicator(color: Colors.white,)
            ],
          ),
        )
    );
  }
}
