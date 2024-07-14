import 'dart:convert';
import 'dart:io';

import 'package:apple/common/component/custom_text_field.dart';
import 'package:apple/common/const/colors.dart';
import 'package:apple/common/const/data.dart';
import 'package:apple/common/layout/default_layout.dart';
import 'package:apple/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String username = '';
  late String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final storage = FlutterSecureStorage();

    final emulatorIp = '10.0.2.2:3000';
    final simulatorIp = '127.0.0.1:3000';

    final ip = Platform.isIOS ? simulatorIp : emulatorIp;

    return DefaultLayout(
      child: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                SizedBox(
                  height: 16.0,
                ),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width * 2 / 3,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                  onChanged: (String Value) {
                    setState(() {
                      username = Value;
                    });
                  },
                  hintText: '이메일을 입력해주세요',
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                    onChanged: (String Value) {
                      password = Value;
                    },
                    hintText: '비밀번호을 입력해주세요'),
                SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final rawString = '$username:$password';

                    Codec<String, String> stringToBase64 = utf8.fuse(base64);
                    String token = stringToBase64.encode(rawString);

                    final response = await dio.post(
                      'http://$ip/auth/login',
                      options: Options(
                        headers: {
                          'authorization': 'Basic $token',
                        },
                      ),
                    );
                    final accessToken = response.data['accessToken'];
                    final refreshToken = response.data['refreshToken'];

                    await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
                    await storage.write(key: REFREAH_TOKEN_KEY, value: refreshToken);

                    print(response.data);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RootTab(),
                      ),
                    );
                  },
                  child: Text('로그인'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      foregroundColor: Colors.white),
                ),
                TextButton(
                  onPressed: () async {
                    final token = '';
                    final response = await dio.post('http://$ip/auth/token',
                        options: Options(
                            headers: {'authorization': 'Bearer $token'}));
                    print(response.data);
                  },
                  child: Text('회원가입'),
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
          color: Colors.black, fontSize: 34, fontWeight: FontWeight.w500),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(color: BODY_TEXT_COLOR),
    );
  }
}
