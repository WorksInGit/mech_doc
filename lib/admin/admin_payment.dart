import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPayment extends StatefulWidget {
  const AdminPayment({super.key});

  @override
  State<AdminPayment> createState() => _AdminPaymentState();
}

class _AdminPaymentState extends State<AdminPayment> {
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
        preferences.setString('imageUrl', imageUrl!);
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 20.w),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 25.r,
                      backgroundImage: adminId != null && imageUrl != null
                          ? NetworkImage(imageUrl!)
                          : AssetImage('assets/icons/person.png')
                              as ImageProvider),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('userRequest')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error : ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  );
                }
                final doc = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, index) {
                    var notiData = doc[index].data() as Map<String, dynamic>;
                    Timestamp timestamp = notiData['timestamp'];
                    DateTime dateTime = timestamp.toDate();
                    String formattedDate =
                        DateFormat('dd/MM/yyyy').format(dateTime);
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Card(
                        color: Colors.transparent,
                        child: Container(
                          width: 200.w,
                          height: 115.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor('3d495b')),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Amount : ',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white)),
                                    Icon(
                                      Icons.currency_rupee_sharp,
                                      color: Colors.white,
                                      size: 15.sp,
                                    ),
                                    Text(notiData['userAmount'],
                                        style: GoogleFonts.poppins(
                                            color: Colors.white)),
                                    Spacer(),
                                    Text(
                                      formattedDate,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      notiData['userName'],
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    Icon(
                                      Iconsax.arrow_right_1,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      notiData['mechName'],
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Service : ${notiData['userService']}',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
