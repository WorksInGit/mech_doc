import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mech_doc/mechanic/request/view_profile.dart';

class EditProfile extends StatefulWidget {
  final String? mechId;
  const EditProfile({super.key, required this.mechId});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }
    File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _uploadToFirebase(_imageFile!);
    }
  }

  Future<void> _uploadToFirebase(File imageFile) async {
    try {
      String fileName =
          'mechProfile/${DateTime.now().microsecondsSinceEpoch}.png';
      final storageRef = FirebaseStorage.instance.ref().child(fileName);
      final UploadTask = await storageRef.putFile(imageFile);
      String downloadUrl = await storageRef.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
      await _updateMechProfile(downloadUrl);
      print('Image upload succesfully');
    } catch (e) {
      print('Error in uploading to firebase : $e');
    }
  }

  Future<void> _updateMechProfile(String downloadUrl) async {
    await FirebaseFirestore.instance
        .collection('mechSignUp')
        .doc(widget.mechId)
        .update({'profile': downloadUrl});
  }

  String? imageUrl;
  Future<void> _loadProfile() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('mechSignUp')
        .doc(widget.mechId)
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
    }
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController _phonoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _expController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _shopController = TextEditingController();
  Future<void> _updateProfileData() async {
      FirebaseFirestore.instance.collection('mechSignUp').doc(widget.mechId).update({
        'userName': _nameController.text,
        'phoneNumber': _phonoController.text,
        'email': _emailController.text,
        'experience': _expController.text,
        'location': _locationController.text,
        'shopName': _shopController.text

        
      });
      Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        body: Stack(
          children: [
           SingleChildScrollView(
             child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 60.r,
                  backgroundImage: imageUrl != null
                      ? NetworkImage(imageUrl!)
                      : AssetImage('assets/icons/profile.png'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: Row(
                    children: [
                      Text(
                        'Name',
                        style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: TextFormField(
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
                              color: Colors.white, fontWeight: FontWeight.w200),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: Row(
                    children: [
                      Text(
                        'Username',
                        style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: TextFormField(
                    style: GoogleFonts.poppins(color: Colors.white),
                    controller: _userController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.r)),
                        filled: true,
                        fillColor: HexColor('3d495b'),
                        label: Text(
                          'Username',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w200),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: Row(
                    children: [
                      Text(
                        'Phone number',
                        style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: TextFormField(
                    style: GoogleFonts.poppins(color: Colors.white),
                    controller: _phonoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.r)),
                        filled: true,
                        fillColor: HexColor('3d495b'),
                        label: Text(
                          'Phone number',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w200),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: Row(
                    children: [
                      Text(
                        'Email',
                        style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: TextFormField(
                    style: GoogleFonts.poppins(color: Colors.white),
                    controller: _emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.r)),
                        filled: true,
                        fillColor: HexColor('3d495b'),
                        label: Text(
                          'Enter email',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w200),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: Row(
                    children: [
                      Text(
                        'Work experience',
                        style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: TextFormField(
                    style: GoogleFonts.poppins(color: Colors.white),
                    controller: _expController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.r)),
                        filled: true,
                        fillColor: HexColor('3d495b'),
                        label: Text(
                          'Enter your experience',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w200),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: TextFormField(
                    style: GoogleFonts.poppins(color: Colors.white),
                    controller: _locationController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.r)),
                        filled: true,
                        fillColor: HexColor('3d495b'),
                        label: Text(
                          'Enter your location',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w200),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: Row(
                    children: [
                      Text(
                        'work shop name',
                        style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: TextFormField(
                    style: GoogleFonts.poppins(color: Colors.white),
                    controller: _shopController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.r)),
                        filled: true,
                        fillColor: HexColor('3d495b'),
                        label: Text(
                          'Enter your shop name',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w200),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () {
                    _updateProfileData();
                  },
                  child: Container(
                    width: 200.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: HexColor('#2357D9'),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
                       ),
           ),
            Padding(
              padding: EdgeInsets.only(left: 200.w, top: 125.h),
              child: IconButton(
                  onPressed: () {
                    _pickImage();
                  },
                  icon: Icon(
                    Iconsax.camera5,
                    size: 35.sp,
                    color: Colors.blue,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
