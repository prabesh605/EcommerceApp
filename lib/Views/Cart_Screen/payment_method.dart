import 'package:ecommerceapp/Views/home.dart';
import 'package:ecommerceapp/common_widgets/our_button.dart';
import 'package:ecommerceapp/consts/list.dart';
import 'package:ecommerceapp/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        appBar: AppBar(
          title: "Choose payment method".text.make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: controller.placingOrder.value == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ourButton(
                  onPressed: () async {
                    controller.placingOrder(true);
                    await controller.placeMyOrder(
                      orderPaymentMethod:
                          paymentMethodsName[controller.paymentIndex.value],
                      totalAmount: controller.totalP.value,
                    );
                    await controller.clearCart();
                    VxToast.show(context, msg: "Order placed successfully");
                    Get.offAll(() => const Home());
                    controller.placingOrder(false);
                  },
                  text: "Place my order",
                  color: Colors.red,
                ),
        ),
        body: Obx(
          () => Column(
            children: List.generate(paymentMethodsImg.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changePaymentIndex(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: 120,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Image.asset(
                        paymentMethodsImg[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                      ),
                      controller.paymentIndex.value == index
                          ? Positioned(
                              top: 5,
                              right: 5,
                              child: Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  value: true,
                                  onChanged: (value) {},
                                ),
                              ),
                            )
                          : Container(),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: paymentMethodsName[index]
                            .text
                            .bold
                            .white
                            .shadowBlur(8)
                            .size(16)
                            .make(),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ));
  }
}
