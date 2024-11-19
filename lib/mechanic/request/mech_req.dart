import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mech_doc/mechanic/request/mech_notification.dart';
import 'package:mech_doc/mechanic/request/mech_req_1.dart';
import 'package:mech_doc/mechanic/request/mech_req_2.dart';
import 'package:mech_doc/mechanic/request/view_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechReq extends StatefulWidget {
  const MechReq({super.key});

  @override
  State<MechReq> createState() => _MechReqState();
}

class _MechReqState extends State<MechReq> {
  String? mechId;
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    _getMechId();
  }

  Future<String?> _getMechId() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('mechId');
    if (id != null) {
      setState(() {
        mechId = id;
      });

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('mechSignUp')
          .doc(mechId)
          .get();
      if (doc.exists) {
        setState(() {
          imageUrl = doc['profile'];
        });
      } else {
        print('Doc not found');
      }
    } else {
      print('Mech id not found in sharedpreferences');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('mechSignUp').doc(mechId).snapshots(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          String url = data!['profile'];
          return Scaffold(
            backgroundColor: HexColor('#222831'),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.h, left: 20.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ViewProfile();
                            },
                          ));
                        },
                        child: CircleAvatar(
                          radius: 27.r,
                          backgroundImage: url != null
                              ? NetworkImage(url)
                              : AssetImage('assets/icons/person.png')
                                  as ImageProvider,
                        ),
                      ),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return MechNotification();
                                  },
                                ));
                              },
                              icon: Icon(
                                Iconsax.notification5,
                                color: Colors.white,
                                size: 30.sp,
                              )))
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
                      unselectedLabelColor: HexColor('#222831'),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor('#3d495b'),
                      ),
                      tabs: [Tab(text: 'Request'), Tab(text: 'Accepted')]),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Expanded(child: TabBarView(children: [MechReq1(), MechReq2()])),
              ],
            ));
        },

      ),
    );
  }
}
