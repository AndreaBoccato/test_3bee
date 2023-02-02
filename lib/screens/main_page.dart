import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:test_3bee/core/instance_locator.dart';
import 'package:test_3bee/screens/home_page.dart';
import 'package:test_3bee/screens/login_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late bool isJwtValid;

  @override
  void initState() {
    super.initState();
    if (localCache.getAccessToken() == null) {
      isJwtValid = false;
    } else {
      isJwtValid = !JwtDecoder.isExpired(localCache.getAccessToken()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isJwtValid) {
      return const HomePage();
    }

    return const LoginPage();
  }
}
