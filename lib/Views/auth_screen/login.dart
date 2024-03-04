import 'package:ecommerceapp/Views/home.dart';
import 'package:ecommerceapp/common_widgets/custom_textfield.dart';
import 'package:ecommerceapp/common_widgets/our_button.dart';
import 'package:ecommerceapp/Views/auth_screen/signin.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 208, 215),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 208, 215),
        automaticallyImplyLeading: false,
        title: "Login".text.make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              iclogo,
              height: 200,
            ),
            customTextField(name: "Email", hint: "Enter your email"),
            5.heightBox,
            customTextField(
                name: "Password", hint: "Enter your password", ispass: true),
            10.heightBox,
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: "Forgot password".text.make(),
              ),
            ),
            ourButton(
                text: "Login",
                onPressed: () {
                  Get.to(() => const Home());
                }).box.width(context.screenWidth - 50).make(),
            TextButton(
                onPressed: () {
                  Get.to(() => const SigninScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Don't have an account?".text.color(Colors.black54).make(),
                    " Sign up".text.color(Colors.red).make()
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
