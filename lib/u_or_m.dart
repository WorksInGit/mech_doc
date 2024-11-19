import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mech_doc/admin/admin_login.dart';
import 'package:mech_doc/mechanic/mech_login.dart';
import 'package:mech_doc/user/user_login.dart';

class UOrM extends StatefulWidget {
  const UOrM({super.key});

  @override
  State<UOrM> createState() => _UOrMState();
}

class _UOrMState extends State<UOrM> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#222831'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icons/mechanic.png'),
                          fit: BoxFit.cover)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.w, top: 30.h),
              child: Row(
                children: [
                  Text(
                    'Who you are ?',
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return MechLogin();
                      },
                    ));
                  },
                  child: Container(
                    width: 300.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: HexColor('3d495b'),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: EdgeInsets.all(10.0.r),
                      child: Text(
                        'Mechanic',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserLogin(),
                        ));
                  },
                  child: Container(
                    width: 300.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: HexColor('3d495b'),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: EdgeInsets.all(10.0.r),
                      child: Text(
                        'User',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminLogin(),
                        ));
                  },
                  child: Container(
                    width: 300.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: HexColor('3d495b'),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: EdgeInsets.all(10.0.r),
                      child: Center(
                        child: Text(
                          'Admin',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
