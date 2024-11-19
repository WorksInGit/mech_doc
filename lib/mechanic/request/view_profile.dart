import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mech_doc/mechanic/bottom_nav.dart';
import 'package:mech_doc/mechanic/request/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  String? mechId;
  String? imageUrl;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController _phonoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _expController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _shopController = TextEditingController();

  Future<void> _loadProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
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
          _nameController.text = doc['userName'];
          _userController.text = doc['userName'];
          _phonoController.text = doc['phoneNumber'];
          _emailController.text = doc['email'];
          _expController.text = doc['experience'];
          _locationController.text = doc['location'];
          _shopController.text = doc['shopName'];
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h, left: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(
                                mechId: mechId,
                              ),
                            ));
                      },
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
                  : AssetImage('assets/icons/person.png'),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                readOnly: true,
                style: GoogleFonts.poppins(color: Colors.white),
                controller: _nameController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.r)),
                    filled: true,
                    fillColor: HexColor('3d495b'),
                    label: Text(
                      'Name',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    )),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                readOnly: true,
                style: GoogleFonts.poppins(color: Colors.white),
                controller: _nameController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.r)),
                    filled: true,
                    fillColor: HexColor('3d495b'),
                    label: Text(
                      'User name',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    )),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                readOnly: true,
                style: GoogleFonts.poppins(color: Colors.white),
                controller: _phonoController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.r)),
                    filled: true,
                    fillColor: HexColor('3d495b'),
                    label: Text(
                      'Phone number',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    )),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                readOnly: true,
                style: GoogleFonts.poppins(color: Colors.white),
                controller: _emailController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.r)),
                    filled: true,
                    fillColor: HexColor('3d495b'),
                    label: Text(
                      'Email',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    )),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                readOnly: true,
                style: GoogleFonts.poppins(color: Colors.white),
                controller: _expController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.r)),
                    filled: true,
                    fillColor: HexColor('3d495b'),
                    label: Text(
                      'Experience',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    )),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                readOnly: true,
                style: GoogleFonts.poppins(color: Colors.white),
                controller: _locationController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.r)),
                    filled: true,
                    fillColor: HexColor('##3d495b'),
                    label: Text(
                      'Location',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    )),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: TextFormField(
                readOnly: true,
                style: GoogleFonts.poppins(color: Colors.white),
                controller: _shopController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.r)),
                    filled: true,
                    fillColor: HexColor('3d495b'),
                    label: Text(
                      'Shop name',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    )),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 200.r,
                height: 50.r,
                decoration: BoxDecoration(
                    color: HexColor('2357D9'),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                  child: Text(
                    'Done',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.r),
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
    );
  }
}
