import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';


class ServiceAR extends StatefulWidget {
  final DocumentSnapshot reqIndex;
  final String docId;
  const ServiceAR({super.key, required this.reqIndex, required this.docId});

  @override
  State<ServiceAR> createState() => _ServiceARState();
}

class _ServiceARState extends State<ServiceAR> {
  Future<void> _acceptStatus() async {
    FirebaseFirestore.instance
        .collection('userRequest')
        .doc(widget.docId)
        .update({'mechStatus': 1});
    
    Navigator.pop(context);
  }
  Future<void> _rejectStatus() async {
    FirebaseFirestore.instance
        .collection('userRequest')
        .doc(widget.docId)
        .update({'mechStatus': 2});
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.reqIndex['userName'];
    String userService = widget.reqIndex['userService'];
    String place = widget.reqIndex['userPlace'];
    String contactNo = widget.reqIndex['phoneNumber'];
    Timestamp timestamp = widget.reqIndex['timestamp'];
    DateTime dateTime = timestamp.toDate();
    String? formattedTime = DateFormat('hh:mm a').format(dateTime);
    String? formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 30.w),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 130.h,
                ),
                Container(
                  width: 330.w,
                  height: 470.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: HexColor('3d495b')),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        name,
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 70.h, left: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              
                              children: [
                                Text(
                                  'Name',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                Text(
                                  'Place',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                Text(
                                  'Date',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                Text(
                                  'Time',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                Text(
                                  'Contact number',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                Text(
                                  place,
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                Text(
                                  formattedDate,
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                Text(
                                  formattedTime,
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                Text(
                                  contactNo,
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 150.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _acceptStatus();
                            },
                            child: Container(
                              width: 100.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: HexColor('#49CD6E')),
                              child: Center(
                                child: Text(
                                  'Accept',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          GestureDetector(
                            onTap: (){
                              _rejectStatus();
                            },
                            child: Container(
                              width: 100.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: HexColor('#CD4949')),
                              child: Center(
                                child: Text(
                                  'Reject',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 120.h, left: 155.w),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40.r,
                backgroundImage: AssetImage('assets/icons/boss.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
