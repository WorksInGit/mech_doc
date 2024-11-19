import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class UserPayment extends StatefulWidget {
  const UserPayment({super.key});

  @override
  State<UserPayment> createState() => _UserPaymentState();
}

class _UserPaymentState extends State<UserPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('222831'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 300.h, left: 50.w),
            child: Column(
              children: [
                Container(
                  width: 200.w,
                  height: 200.h,
                  child: LottieBuilder.asset('assets/animations/online_banking.json'),
                ),
                Text(
                  'Successfull',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                      fontWeight: FontWeight.w500, fontSize: 20.sp),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 50.h, left: 50.w),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 300.w,
                height: 50.h,
                decoration: BoxDecoration(
                    color: HexColor('#2357D9'),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                  child: Text(
                    'Back to home page',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
