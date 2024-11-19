import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mech_doc/admin/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passController.text.trim();
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('adminLogin')
      .where('email', isEqualTo: email).where('password', isEqualTo: password).get();
      if (querySnapshot.docs.isNotEmpty) {
        String adminId = querySnapshot.docs[0].id;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('adminId', adminId);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav(),));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid email or password')));
      }
    }catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error logging in')));
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
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
                          'Username',
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
                SizedBox(
                  height: 80.h,
                ),
                GestureDetector(
                  onTap: () {
                      _login();
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
                  height: 40.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
