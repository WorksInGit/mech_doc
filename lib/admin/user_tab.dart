import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mech_doc/admin/admin_user.dart';

class UserTab extends StatefulWidget {
  const UserTab({super.key});

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('userSignUp').snapshots(),
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
        final user = snapshot.data!.docs;

        return ListView.builder(
          itemCount: user.length,
          itemBuilder: (context, index) {
            var userIndex = snapshot.data!.docs[index];
            var userData = user[index].data() as Map<String, dynamic>;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminUser(userIndex: userIndex),
                      ));
                },
                child: Card(
                  
                  child: Container(
                    width: 300.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor('#3d495b')),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          width: 55.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100).r,
                              image: DecorationImage(
                                image: NetworkImage(userData['profile']),fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData['userName'],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Text(
                              userData['location'],
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            Text(
                              userData['phoneNumber'],
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            Text(
                              userData['email'],
                              style: GoogleFonts.poppins(color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
