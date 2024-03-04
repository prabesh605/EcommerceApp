import 'package:ecommerceapp/Views/Cart_Screen/cart_screen.dart';
import 'package:ecommerceapp/Views/Category_screen/category_screen.dart';
import 'package:ecommerceapp/Views/Home_screen/home_screen.dart';
import 'package:ecommerceapp/Views/Profile_Screen/profile_screen.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:ecommerceapp/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            ichome,
            width: 26,
          ),
          label: "Home"),
      BottomNavigationBarItem(
          icon: Image.asset(
            iccategory,
            width: 26,
          ),
          label: "Category"),
      BottomNavigationBarItem(
          icon: Image.asset(
            iccart,
            width: 26,
          ),
          label: "Cart"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icaccount,
            width: 26,
          ),
          label: "Account"),
    ];
    return Obx(
      () => Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            items: navbarItem,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.red,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
          body: Column(
            children: [
              Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ],
          )),
    );
  }
}
