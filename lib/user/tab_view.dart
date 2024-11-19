import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mech_doc/user/user_mech.dart';
import 'package:mech_doc/user/user_notification.dart';
import 'package:mech_doc/user/user_profile.dart';
import 'package:mech_doc/user/user_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTabView extends StatefulWidget {
  const UserTabView({super.key});

  @override
  State<UserTabView> createState() => _UserTabViewState();
}

class _UserTabViewState extends State<UserTabView> {
  String? adminId;
  String? imageUrl;
  String? searchQuery = '';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAdminId();
  }

  Future<String?> getAdminId() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('userLoginId');
    if (id != null) {
      setState(() {
        adminId = id;
      });

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('userSignUp')
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
      print('User id not found in sharedpreferences');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: HexColor('222831'),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: HexColor('222831'),
              actions: [
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return UserProfile();
                        },
                      ));
                    },
                    child: CircleAvatar(
                      radius: 23.r,
                      backgroundImage: imageUrl != null && adminId != null
                          ? NetworkImage(imageUrl!)
                          : AssetImage('assets/icons/person.png')
                              as ImageProvider,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10.h),
                    child: TextField(
                      style: GoogleFonts.poppins(color: Colors.white),
                      controller: _searchController,
                      decoration: InputDecoration(
                        label: Text(
                          'search',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontSize: 15.sp),
                        ),
                        prefixIcon: Icon(
                          Iconsax.search_normal_1,
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide(color: Colors.transparent)),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: HexColor('3d495b'),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserNotification(),
                              ));
                        },
                        icon: Icon(
                          Iconsax.notification5,
                          color: Colors.white,
                          size: 30.sp,
                        )))
              ],
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: TabBarView(children: [
                        UserMech(
                          searchQuery: searchQuery,
                          collectionName: 'mechSignUp',
                        ),
                        UserRequest()
                      ]),
                    ),
                    SizedBox(
                      height: 100.h,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h, left: 30.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 330.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Colors.grey),
                        child: TabBar(
                            labelStyle: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: HexColor('#2357D9'),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              shape: BoxShape.rectangle,
                              color: HexColor('#3d495b'),
                            ),
                            dividerColor: Colors.transparent,
                            tabs: [
                              Tab(
                                text: 'Mechanic',
                              ),
                              Tab(
                                text: 'Request',
                              )
                            ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
