import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class AddNotification extends StatefulWidget {
  const AddNotification({super.key});

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  TextEditingController matterController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  Future<void> addNotification() async {
    if (matterController.text.isEmpty || contentController.text.isEmpty) {
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
    FirebaseFirestore.instance.collection('notification').add(
        {'matter': matterController.text, 'content': contentController.text,
        
        'timestamp': FieldValue.serverTimestamp()
        });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: HexColor('222831'),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 20.w),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        )
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.w, top: 50.h),
                  child: Row(
                    children: [
                      Text(
                        'Enter Matter',
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
                    controller: matterController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.r)),
                        filled: true,
                        fillColor: Colors.white,
                        label: Text(
                          'Matter',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontWeight: FontWeight.w300),
                        )),
                  ),
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
                    controller: contentController,
                    maxLines: 15,
                    decoration: InputDecoration(
                      hintStyle:
                          GoogleFonts.poppins(fontWeight: FontWeight.w300),
                      hintText: 'Content . . . .',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () {
                    addNotification();
                  },
                  child: Container(
                    width: 200.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: HexColor('2357D9'),
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
