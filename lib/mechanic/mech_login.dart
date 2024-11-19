import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mech_doc/mechanic/bottom_nav.dart';
import 'package:mech_doc/mechanic/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechLogin extends StatefulWidget {
  const MechLogin({super.key});

  @override
  State<MechLogin> createState() => _MechLoginState();
}

class _MechLoginState extends State<MechLogin> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  Future<void> _mechLogin() async {
    String? email = _emailController.text.trim();
    String? password = _passController.text.trim();
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('mechSignUp')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .where('status', isEqualTo: 1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        String? mechId = querySnapshot.docs[0].id;
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('mechId', mechId);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return BottomNav();
          },
        ));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid email or password')));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error in log in')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
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
              SizedBox(
                height: 40.h,
              ),
              Text(
                'LOGIN',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w, top: 50.h),
                child: Row(
                  children: [
                    Text(
                      'Enter email',
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r)),
                      filled: true,
                      fillColor: Colors.white,
                      label: Text(
                        'Email',
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      )),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w, top: 30.h),
                child: Row(
                  children: [
                    Text(
                      'Enter password',
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r)),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter password',
                      hintStyle:
                          GoogleFonts.poppins(fontWeight: FontWeight.w300)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 180.w, top: 20.h),
                child: Text(
                  'Forgot password?',
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              GestureDetector(
                onTap: () {
                  _mechLogin();
                },
                child: Container(
                  width: 200.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: HexColor('#2357D9'),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do you have account? ',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MechSignUp();
                          },
                        ));
                      },
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.poppins(color: HexColor('#2357D9')),
                      ))
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
