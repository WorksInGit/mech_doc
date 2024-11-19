import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mech_doc/mechanic/bottom_nav.dart';

class MechSignUp extends StatefulWidget {
  const MechSignUp({super.key});

  @override
  State<MechSignUp> createState() => _MechSignUpState();
}

class _MechSignUpState extends State<MechSignUp> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _expController = TextEditingController();
  TextEditingController _shopController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  Future<void> addData() async {
    if (_userController.text.isEmpty ||
        _phoneNumber.text.isEmpty ||
        _emailController.text.isEmpty ||
        _expController.text.isEmpty ||
        _shopController.text.isEmpty ||
        _passController.text.isEmpty ||
        _locationController.text.isEmpty) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: HexColor('3d495b'),
            title: Row(
              children: [
                Text(
                  'Message',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Icon(
                  Iconsax.warning_2,
                  color: Colors.white,
                )
              ],
            ),
            actions: [
              Center(
                  child: Row(
                children: [
                  Text(
                    'Please fill all the required fields',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ],
              )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                    style: GoogleFonts.poppins(color: Colors.blue),
                  ))
            ],
          );
        },
      );
    }
    FirebaseFirestore.instance.collection('mechSignUp').add({
      'userName': _userController.text,
      'phoneNumber': _phoneNumber.text,
      'email': _emailController.text,
      'experience': _expController.text,
      'shopName': _shopController.text,
      'password': _passController.text,
      'status': 0,
      'location': _locationController.text,
      'profile': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGD0BcxwuvdI1H-S35GmT43vP2MBIdCgyeIA&s'
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 20.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Text(
                'SIGN UP',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w),
                child: Row(
                  children: [
                    Text(
                      'Enter username',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
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
                  controller: _userController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r)),
                      filled: true,
                      fillColor: Colors.white,
                      label: Text(
                        'Username',
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      )),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w),
                child: Row(
                  children: [
                    Text(
                      'Enter Phone number',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
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
                  controller: _phoneNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r)),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Phone number',
                      hintStyle:
                          GoogleFonts.poppins(fontWeight: FontWeight.w300)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w, top: 5.h),
                child: Row(
                  children: [
                    Text(
                      'Enter your email',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
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
                  controller: _emailController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r)),
                      filled: true,
                      fillColor: Colors.white,
                      label: Text(
                        'Enter email',
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w, top: 5.h),
                child: Row(
                  children: [
                    Text(
                      'Enter your work experience  ',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
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
                  controller: _expController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r)),
                      filled: true,
                      fillColor: Colors.white,
                      label: Text(
                        'Enter your experience  ',
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w, top: 5.h),
                child: Row(
                  children: [
                    Text(
                      'Enter your work shop name  ',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
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
                  controller: _shopController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r)),
                      filled: true,
                      fillColor: Colors.white,
                      label: Text(
                        'Enter your shop name',
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w),
                child: Row(
                  children: [
                    Text(
                      'Enter Password',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
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
                  controller: _passController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r)),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your password ',
                      hintStyle:
                          GoogleFonts.poppins(fontWeight: FontWeight.w300)),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w),
                child: Row(
                  children: [
                    Text(
                      'Enter Location',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
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
                  controller: _locationController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r)),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your location ',
                      hintStyle:
                          GoogleFonts.poppins(fontWeight: FontWeight.w300)),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () {
                  addData();
                },
                child: Container(
                  width: 200.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: HexColor('#2357D9'),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Text(
                      'SIGN UP',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
