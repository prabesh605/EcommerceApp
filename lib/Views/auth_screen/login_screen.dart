import 'package:ecommerceapp/Views/home.dart';
import 'package:ecommerceapp/common_widgets/custom_textfield.dart';
import 'package:ecommerceapp/common_widgets/our_button.dart';
import 'package:ecommerceapp/Views/auth_screen/signin_screen.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:ecommerceapp/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 229, 208, 215),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 229, 208, 215),
          automaticallyImplyLeading: false,
          title: "Login".text.make(),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Image.asset(
                  iclogo,
                  height: 200,
                ),
                customTextField(
                    name: "Email",
                    hint: "Enter your email",
                    controller: controller.loginEmailController),
                5.heightBox,
                customTextField(
                    name: "Password",
                    hint: "Enter your password",
                    ispass: true,
                    controller: controller.loginPasswordController),
                10.heightBox,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: "Forgot password".text.make(),
                  ),
                ),
                controller.isloading.value
                    ? const CircularProgressIndicator()
                    : ourButton(
                        text: "Login",
                        onPressed: () async {
                          controller.isloading.value = true;
                          await controller
                              .loginMethod(
                                  context: context,
                                  email: controller.loginEmailController.text,
                                  password:
                                      controller.loginPasswordController.text)
                              .then((value) {
                            if (value != null) {
                              VxToast.show(context, msg: "Logged in ");
                              Get.offAll(() => const Home());
                              controller.isloading.value = false;
                            }
                          });
                        }).box.width(context.screenWidth - 50).make(),
                TextButton(
                  onPressed: () {
                    Get.to(() => const SigninScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Don't have an account?"
                          .text
                          .color(Colors.black54)
                          .make(),
                      " Sign up".text.color(Colors.red).make()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
