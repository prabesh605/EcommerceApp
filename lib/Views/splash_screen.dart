import 'dart:async';

import 'package:ecommerceapp/Views/auth_screen/login_screen.dart';
import 'package:ecommerceapp/Views/home.dart';
import 'package:ecommerceapp/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // changeScreen() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     Get.off(() => const LoginScreen());
  //   });

  // }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.off(() => const LoginScreen());
        } else {
          Get.off(() => const Home());
        }
      });
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
