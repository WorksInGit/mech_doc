import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mech_doc/admin/mechanic_tab.dart';
import 'package:mech_doc/admin/user_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  String? adminId;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    getAdminId();
  }

  Future<String?> getAdminId() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('adminId');
    if (id != null) {
      setState(() {
        adminId = id;
      });
      String? storedImageUrl = preferences.getString('imageUrl');
      if (storedImageUrl != null) {
        setState(() {
          imageUrl = storedImageUrl;
        });
      }
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('adminLogin')
          .doc(adminId)
          .get();
      if (doc.exists) {
        setState(() {
          imageUrl = doc['profile'];
        });
      } else {
        print('Doc not found');
      }
    } else {
      print('Admin id not found in sharedpreferences');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: HexColor('222831'),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.h, left: 20.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 27.r,
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl!)
                          : AssetImage('assets/icons/person.png')
                              as ImageProvider,
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                width: 350.w,
                height: 50.h,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: TabBar(
                    dividerColor: Colors.transparent,
                    labelStyle: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor('#3d495b')),
                    tabs: [Tab(text: 'User'), Tab(text: 'Mechanic')]),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(child: TabBarView(children: [UserTab(), MechanicTab()])),
            ],
          )),
    );
  }
}
