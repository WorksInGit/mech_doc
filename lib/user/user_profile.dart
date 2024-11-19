import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  String? imageUrl;
  String? userId;

  Future<void> fetchData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userLoginId');
    print(userId);
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('userSignUp')
        .doc(userId)
        .get();
    if (doc.exists) {
      setState(() {
        imageUrl = doc['profile'];
        _nameController.text = doc['userName'];
        _phoneController.text = doc['phoneNumber'];
        _emailController.text = doc['email'];
      });
    } else {
      print('Doc not exits');
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
              Padding(
                padding: EdgeInsets.only(top: 20.h, right: 10.w),
                child: Row(
                  children: [
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Iconsax.edit4,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              CircleAvatar(
                radius: 50.r,
                backgroundImage: imageUrl != null
                    ? NetworkImage(imageUrl!)
                    : AssetImage('assets/icons/person.png') as ImageProvider,
              ),
              Text('Name'),
              Padding(
                padding: EdgeInsets.only(left: 40.w, top: 50.h),
                child: Row(
                  children: [
                    Text(
                      'Enter your name',
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
                  readOnly: true,
                  controller: _nameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.r)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
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
                      'Enter your phone number',
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
                  controller: _phoneController,
                  readOnly: true,
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
                padding: EdgeInsets.only(left: 40.w, top: 30.h),
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
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: TextFormField(
                  controller: _emailController,
                  readOnly: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r)),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter email',
                      hintStyle:
                          GoogleFonts.poppins(fontWeight: FontWeight.w300)),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 200.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: HexColor('#2357D9'),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Text(
                      'Done',
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
            ],
          ),
        ),
      ),
    );
  }
}
