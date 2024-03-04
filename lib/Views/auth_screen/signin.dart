import 'package:ecommerceapp/Views/home.dart';
import 'package:ecommerceapp/common_widgets/custom_textfield.dart';
import 'package:ecommerceapp/common_widgets/our_button.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        automaticallyImplyLeading: false,
        title: "SignIn".text.make(),
      ),
      body: Column(
        children: [
          Image.asset(
            iclogo,
            height: 200,
          ),
          customTextField(name: "Email", hint: "Enter your email"),
          5.heightBox,
          customTextField(
              name: "Password", hint: "Enter your password", ispass: true),
          5.heightBox,
          customTextField(
              name: "Comfirm Password",
              hint: "Enter your password",
              ispass: true),
          20.heightBox,
          ourButton(
              text: "SignIn",
              onPressed: () {
                Get.to(() => const Home());
              }).box.width(context.screenWidth - 50).make(),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Already have account?".text.color(Colors.black54).make(),
                " Sign In".text.color(Colors.red).make()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
