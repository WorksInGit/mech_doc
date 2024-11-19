import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminMechanic extends StatefulWidget {
  final QueryDocumentSnapshot mechIndex;
  const AdminMechanic({super.key, required this.mechIndex});

  @override
  State<AdminMechanic> createState() => _AdminMechanicState();
}

class _AdminMechanicState extends State<AdminMechanic> {
  Future<void> _acceptStatus() async {
    await FirebaseFirestore.instance
        .collection('mechSignUp')
        .doc(widget.mechIndex.id)
        .update(
      {'status': 1},
    );
    Navigator.pop(context);
  }

  Future<void> _rejectStatus() async {
    await FirebaseFirestore.instance
        .collection('mechSignUp')
        .doc(widget.mechIndex.id)
        .update({'status': 2});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.mechIndex['userName'];
    String location = widget.mechIndex['location'];
    String phoneNo = widget.mechIndex['phoneNumber'];
    String _email = widget.mechIndex['email'];
    String exp = widget.mechIndex['experience'];
    String shopName = widget.mechIndex['shopName'];
    String profile = widget.mechIndex['profile'];
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 20.w),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            CircleAvatar(radius: 40.r, backgroundImage: NetworkImage(profile)),
            Text(
              name,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp),
            ),
            Text(
              location,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w, top: 5.h),
              child: Row(
                children: [
                  Text(
                    'Mech username',
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                readOnly: true,
                initialValue: name,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.r)),
                  filled: true,
                  fillColor: HexColor('#E8F1FF'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w, top: 5.h),
              child: Row(
                children: [
                  Text(
                    'Phone number',
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                readOnly: true,
                initialValue: phoneNo,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.r)),
                  filled: true,
                  fillColor: HexColor('#E8F1FF'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w, top: 5.h),
              child: Row(
                children: [
                  Text(
                    'Email address',
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                initialValue: _email,
                readOnly: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.r)),
                  filled: true,
                  fillColor: HexColor('#E8F1FF'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w, top: 5.h),
              child: Row(
                children: [
                  Text(
                    'Work experience',
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                initialValue: exp,
                readOnly: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.r)),
                  filled: true,
                  fillColor: HexColor('#E8F1FF'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w, top: 5.h),
              child: Row(
                children: [
                  Text(
                    'Work shop name',
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                initialValue: shopName,
                readOnly: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.r)),
                  filled: true,
                  fillColor: HexColor('#E8F1FF'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w, top: 5.h),
              child: Row(
                children: [
                  Text(
                    'Your location',
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                initialValue: location,
                readOnly: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.r)),
                  filled: true,
                  fillColor: HexColor('#E8F1FF'),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _acceptStatus(),
                  child: Container(
                    width: 130.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Center(
                      child: Text(
                        'Accept',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () => _rejectStatus(),
                  child: Container(
                    width: 130.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Center(
                      child: Text(
                        'Reject',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17.sp),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
