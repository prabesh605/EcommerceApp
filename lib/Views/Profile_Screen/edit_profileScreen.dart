// ignore: file_names
import 'dart:io';

import 'package:ecommerceapp/common_widgets/custom_textfield.dart';
import 'package:ecommerceapp/common_widgets/our_button.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:ecommerceapp/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, this.data});

  final dynamic data;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    controller.namecontroller.text = widget.data['name'];

    return Scaffold(
      appBar: AppBar(
        title: 'Edit Profile'.text.make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Stack(
                children: [
                  SizedBox(
                    height: 200,
                    child: controller.profileImgPath.isEmpty
                        ? Image.asset(
                            model5,
                            width: 180,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.profileImgPath.value),
                            width: 180,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                  ),
                  Positioned(
                    bottom: 50,
                    right: 5,
                    child: GestureDetector(
                      onTap: () async {
                        controller.changeImage(context);
                        await controller.uploadProfileImage();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            customTextField(
              controller: controller.namecontroller,
              name: "Name",
              hint: "Edit your name",
            ),
            10.heightBox,
            customTextField(
              controller: controller.oldpasswordController,
              name: "Old Password",
              hint: "Enter your old password",
              ispass: true,
            ),
            10.heightBox,
            customTextField(
              controller: controller.newpasswordController,
              name: "New Password",
              hint: "Enter a new password",
              ispass: true,
            ),
            20.heightBox,
            SizedBox(
              width: context.screenWidth - 50,
              child: ourButton(
                onPressed: () async {
                  //if old password matches database
                  if (widget.data['password'] ==
                      controller.oldpasswordController.text) {
                    await controller.changeAuthPassword(
                        email: widget.data['email'],
                        password: controller.oldpasswordController.text,
                        newpassword: controller.newpasswordController.text);
                    await controller.changePassword(
                        name: controller.namecontroller.text,
                        password: controller.newpasswordController.text);

                    // ignore: use_build_context_synchronously
                    VxToast.show(context, msg: "Updated");
                  } else {
                    VxToast.show(context, msg: "Wrong old password");
                  }
                },
                text: "Save",
              ),
            ),
          ],
        ).box.white.padding(const EdgeInsets.all(16)).make(),
      ),
    );
  }
}
