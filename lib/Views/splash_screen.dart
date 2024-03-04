import 'dart:async';

import 'package:ecommerceapp/Views/auth_screen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Get.to(() => const LoginScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Welcome to "
                .text
                .fontWeight(FontWeight.normal)
                .size(20)
                .makeCentered(),
            Image.asset(
              "assets/icons/logo.png",
              height: 100,
            ),
            "@Prabesh".text.make()
          ],
        ),
      ),
    );
  }
}
