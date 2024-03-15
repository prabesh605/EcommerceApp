import 'package:ecommerceapp/Views/Cart_Screen/payment_method.dart';
import 'package:ecommerceapp/common_widgets/custom_textfield.dart';
import 'package:ecommerceapp/common_widgets/our_button.dart';
import 'package:ecommerceapp/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: "Shipping Info".text.make(),
      ),
      bottomNavigationBar: ourButton(
          onPressed: () {
            if (controller.addressController.text.length > 5
                //          &&
                // controller.cityController.text.isNotEmpty &&
                // controller.stateController.text.isNotEmpty &&
                // controller.postalcodeController.text.isNotEmpty &&
                // controller.phoneController.text.isNotEmpty
                ) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
          text: "Continue",
          color: Colors.red),
      body: Column(
        children: [
          customTextField(
            controller: controller.addressController,
            hint: "Enter your adress",
            name: "Address",
          ),
          customTextField(
            controller: controller.cityController,
            hint: "Enter your city",
            name: "City",
          ),
          customTextField(
            controller: controller.stateController,
            hint: "Enter your state",
            name: "State",
          ),
          customTextField(
            controller: controller.postalcodeController,
            hint: "Enter your postal code",
            name: "Postal Code",
          ),
          customTextField(
            controller: controller.phoneController,
            hint: "Enter your phone number",
            name: "Phone",
          ),
        ],
      ),
    );
  }
}
