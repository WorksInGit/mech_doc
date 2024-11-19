import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class MechAccepted extends StatefulWidget {
  final DocumentSnapshot reqIndex;
  const MechAccepted({super.key, required this.reqIndex});

  @override
  State<MechAccepted> createState() => _MechAcceptedState();
}

class _MechAcceptedState extends State<MechAccepted> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  Future<void> _updateAmount() async {
    FirebaseFirestore.instance
        .collection('userRequest')
        .doc(widget.reqIndex.id)
        .update({'userAmount': _amountController.text,
        'paymentStatus': 3
        });
    Navigator.pop(context);
  }
 Future<void> _addReason() async {
    FirebaseFirestore.instance.collection('userRequest').doc(widget.reqIndex.id).update({
      'mechReason': _reasonController.text,
      'paymentStatus': 4
    });
    Navigator.pop(context);
  }

  String? radioValue = 'Completed';
  @override
  Widget build(BuildContext context) {
    String? userProfile = widget.reqIndex['userProfile'];
    String? userName = widget.reqIndex['userName'];
    String? userService = widget.reqIndex['userService'];
    Timestamp timestamp = widget.reqIndex['timestamp'];
    DateTime dateTime = timestamp.toDate();
    String? formattedTime = DateFormat('hh:mm a').format(dateTime);
    String? formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    String? userPlace = widget.reqIndex['userPlace'];
    String? userId = widget.reqIndex.id;

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 10.h),
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.w),
                child: Card(
                  color: HexColor('3d495b'),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 30.r,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(userProfile!)),
                          Text(
                            userName!,
                            style: GoogleFonts.poppins(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(userService!,
                              style: GoogleFonts.poppins(color: Colors.white)),
                          Text(formattedDate,
                              style: GoogleFonts.poppins(color: Colors.white)),
                          Text(formattedTime,
                              style: GoogleFonts.poppins(color: Colors.white)),
                          Text(userPlace!,
                              style: GoogleFonts.poppins(color: Colors.white)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100.h, left: 30.w),
                child: Row(
                  children: [
                    Text(
                      'Add status',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Radio(
                    value: 'Completed',
                    groupValue: radioValue,
                    onChanged: (value) {
                      setState(() {
                        radioValue = value;
                      });
                    },
                  ),
                  Text(
                    'Completed',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  Radio(
                    value: 'Not Completed',
                    groupValue: radioValue,
                    onChanged: (value) {
                      setState(() {
                        radioValue = value;
                      });
                    },
                  ),
                  Text(
                    'Not Completed',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ],
              ),
              radioValue == 'Completed'
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 40.w, top: 60.h),
                          child: Row(
                            children: [
                              Text(
                                'Amount',
                                style: GoogleFonts.poppins(
                                    fontSize: 20.sp, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 70.h,
                        ),
                        Container(
                            width: 230.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.white)),
                            child: TextField(
                              controller: _amountController,
                              style: GoogleFonts.poppins(color: Colors.white),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                Icons.currency_rupee_sharp,
                                color: Colors.white,
                              )),
                            )),
                        SizedBox(
                          height: 100.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            _updateAmount();
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
                          height: 20.h,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 40.w, top: 60.h),
                          child: Row(
                            children: [
                              Text(
                                'Reject reason',
                                style: GoogleFonts.poppins(
                                    fontSize: 20.sp, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          width: 339.w,
                          height: 170.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.white)),
                          child: TextField(
                            controller: _reasonController,
                            style: GoogleFonts.poppins(color: Colors.white),
                            maxLines: 6,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            _addReason();
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
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
