import 'package:ecommerceapp/Views/home.dart';
import 'package:ecommerceapp/common_widgets/custom_textfield.dart';
import 'package:ecommerceapp/common_widgets/our_button.dart';
import 'package:ecommerceapp/consts/firebase_consts.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:ecommerceapp/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    //text controllers

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          automaticallyImplyLeading: false,
          title: "Sign up".text.make(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                iclogo,
                height: 180,
              ),
              customTextField(
                  name: "Name",
                  hint: "Enter your Name",
                  controller: controller.nameControllers),
              5.heightBox,
              customTextField(
                  name: "Email",
                  hint: "Enter your email",
                  controller: controller.emailController),
              5.heightBox,
              customTextField(
                  name: "Password",
                  hint: "Enter your password",
                  ispass: true,
                  controller: controller.passwordController),
              5.heightBox,
              customTextField(
                name: "Comfirm Password",
                hint: "Enter your password",
                ispass: true,
                controller: controller.passwordconfirmController,
                errorText: controller.passwordController.text !=
                        controller.passwordconfirmController.text
                    ? "Passwords do not match"
                    : null,
              ),
              20.heightBox,
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.red,
                            checkColor: Colors.white,
                            value: controller.isCheck.value,
                            onChanged: (newValue) {
                              controller.setCheck(newValue!);
                            },
                          ),
                          10.widthBox,
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "I agree to the",
                                  style: TextStyle(color: Colors.black87),
                                ),
                                TextSpan(
                                  text: " term and Condition",
                                  style: TextStyle(color: Colors.red),
                                ),
                                TextSpan(
                                  text: " & ",
                                  style: TextStyle(color: Colors.black87),
                                ),
                                TextSpan(
                                  text: "privacy policy",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ourButton(
                          text: "Sign up",
                          color: controller.isCheck.value == true
                              ? Colors.red
                              : Colors.black12,
                          onPressed: () async {
                            if (controller.isCheck.value != false) {
                              if (controller.passwordController.text ==
                                  controller.passwordconfirmController.text) {
                                try {
                                  await controller
                                      .signupMethod(
                                          context: context,
                                          email:
                                              controller.emailController.text,
                                          password: controller
                                              .passwordController.text)
                                      .then((value) {
                                    return controller.storeUserData(
                                      email: controller.emailController.text,
                                      password:
                                          controller.passwordController.text,
                                      name: controller.nameControllers.text,
                                    );
                                  }).then((value) {
                                    VxToast.show(context, msg: "Logged in");
                                    Get.offAll(() => const Home());
                                  });
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                }
                              }
                            }
                          }).box.width(context.screenWidth - 50).make(),
                    ],
                  ),
                ),
              ),
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
        ),
      ),
    );
  }
}
