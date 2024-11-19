import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mech_doc/admin/admin_notification.dart';
import 'package:mech_doc/admin/admin_payment.dart';
import 'package:mech_doc/admin/tab_view.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final List<Widget> pages = [TabView(), AdminPayment(), AdminNotification()];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            currentIndex: selectedIndex,
            backgroundColor: HexColor('3d495b'),
            
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: 
                  selectedIndex == 0 ? 
                  Icon(Iconsax.home_25,color: Colors.white,) :  Icon(Iconsax.home_24,color: Colors.white,),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: 
                  selectedIndex == 1 ? 
                  Icon(Iconsax.money_send5,color: Colors.white,) : Icon(Iconsax.money_send4,color: Colors.white,),
                  label: 'Payment'),
              BottomNavigationBarItem(
                  icon:
                  selectedIndex == 2 ?  
                   Icon(Iconsax.notification5,color: Colors.white,) : Icon(Iconsax.notification4,color: Colors.white,),
                  label: 'Notification'),
            ]),
      ),
    );
  }
}
