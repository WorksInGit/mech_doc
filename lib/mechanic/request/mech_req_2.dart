import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mech_doc/admin/mechanic_tab.dart';
import 'package:mech_doc/mechanic/request/mech_accepted.dart';
import 'package:mech_doc/user/mech_bill.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechReq2 extends StatefulWidget {
  const MechReq2({super.key});

  @override
  State<MechReq2> createState() => _MechReq2State();
}

class _MechReq2State extends State<MechReq2> {
  @override
  void initState() {
    super.initState();
    _getMechId();
  }

  String? mechId;
  Future<void> _getMechId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('mechId');
    setState(() {
      mechId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('userRequest')
          .where('mechId', isEqualTo: mechId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error : ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.grey,
            ),
          );
        }
        final doc = snapshot.data!.docs;
        return ListView.builder(
          itemCount: doc.length,
          itemBuilder: (context, index) {
            var reqIndex = snapshot.data!.docs[index];
            var reqData = doc[index].data() as Map<String, dynamic>;
            Timestamp timestamp = reqData['timestamp'];
            DateTime dateTime = timestamp.toDate();
            String formattedTime = DateFormat('hh:mm a').format(dateTime);
            String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
            int mechStatus = reqData['mechStatus'];
            int paymentStatus = reqData['paymentStatus'];
            return GestureDetector(
              onTap: () {
                paymentStatus == 3
                    ? showDialog(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 150.h, horizontal: 15.w),
                            child: AlertDialog(
                              backgroundColor: HexColor('222831'),
                              title: Text(
                                'Message',
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              content: Column(
                                children: [
                                  Container(
                                    width: 200.w,
                                    height: 200.h,
                                    child: LottieBuilder.asset(
                                        'assets/animations/PIN Code.json'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(13.0),
                                    child: Text(
                                      'The payment have not been completed yet !',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 16.sp),
                                    ),
                                  )
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok',
                                        style: GoogleFonts.poppins(
                                            color: Colors.grey)))
                              ],
                            ),
                          );
                        },
                      )
                    : paymentStatus == 4
                        ? showDialog(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 150.h, horizontal: 15.w),
                                child: AlertDialog(
                                  backgroundColor: HexColor('222831'),
                                  title: Text(
                                    'Message',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                  content: Column(
                                    children: [
                                      Container(
                                        width: 200.w,
                                        height: 200.h,
                                        child: LottieBuilder.asset(
                                            'assets/animations/Timer.json'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        child: Text(
                                          'The have been failed to complete the work after the approval !',
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 16.sp),
                                        ),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Ok',
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey)))
                                  ],
                                ),
                              );
                            },
                          )
                        : paymentStatus == 5
                            ? showDialog(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 150.h, horizontal: 15.w),
                                      child: AlertDialog(
                                        backgroundColor: HexColor('222831'),
                                        title: Text(
                                          'Message',
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                        content: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 200.w,
                                              height: 200.h,
                                              child: LottieBuilder.asset(
                                                  'assets/animations/Fitness Dancer.json'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 40.w),
                                              child: Text(
                                                'The payment have completed!',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 16.sp),
                                              ),
                                            )
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Ok',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.grey)))
                                        ],
                                      ));
                                },
                              )
                            : mechStatus == 0
                                ? showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 150.h, horizontal: 15.w),
                                        child: AlertDialog(
                                          backgroundColor: HexColor('222831'),
                                          title: Text(
                                            'Message',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          ),
                                          content: Column(
                                            children: [
                                              Container(
                                                width: 200.w,
                                                height: 200.h,
                                                child: LottieBuilder.asset(
                                                    'assets/animations/Secured.json'),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(13.0),
                                                child: Text(
                                                  'Please approve the request to continue !',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 16.sp),
                                                ),
                                              )
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Ok',
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey)))
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : mechStatus == 1
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MechAccepted(reqIndex: reqIndex),
                                        ))
                                    : mechStatus == 2
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 150.h,
                                                    horizontal: 15.w),
                                                child: AlertDialog(
                                                  backgroundColor:
                                                      HexColor('222831'),
                                                  title: Text(
                                                    'Message',
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white),
                                                  ),
                                                  content: Column(
                                                    children: [
                                                      Container(
                                                        width: 200.w,
                                                        height: 200.h,
                                                        child: LottieBuilder.asset(
                                                            'assets/animations/Blocked User.json'),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          'You have rejected the request',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      16.sp),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('Ok',
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .grey)))
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : null;
              },
              child: Padding(
                padding: EdgeInsets.only(left: 7.w, right: 7.w, bottom: 10.h),
                child: Card(
                  color: HexColor('3d495b'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 30.w,
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 30.r,
                                  backgroundImage:
                                      NetworkImage(reqData['userProfile'])),
                              Text(reqData['userName'],
                                  style: GoogleFonts.poppins(color: Colors.white))
                            ],
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            children: [
                              Text(reqData['userService'],
                                  style:
                                      GoogleFonts.poppins(color: Colors.white)),
                              Text(formattedDate,
                                  style:
                                      GoogleFonts.poppins(color: Colors.white)),
                              Text(formattedTime,
                                  style:
                                      GoogleFonts.poppins(color: Colors.white)),
                              Text(reqData['userPlace'],
                                  style:
                                      GoogleFonts.poppins(color: Colors.white)),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: Container(
                              width: paymentStatus == 5
                                  ? 120.w
                                  : paymentStatus == 3
                                      ? 120.w
                                      : 60.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  color: paymentStatus == 3
                                      ? Colors.orange
                                      : paymentStatus == 4
                                          ? Colors.red
                                          : paymentStatus == 5
                                              ? Colors.green
                                              : mechStatus == 0
                                                  ? Colors.orange
                                                  : mechStatus == 1
                                                      ? Colors.green
                                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              child: FittedBox(
                                fit: BoxFit.none,
                                child: Text(
                                  paymentStatus == 3
                                      ? 'Payment pending'
                                      : paymentStatus == 4
                                          ? 'Failed'
                                          : paymentStatus == 5
                                              ? 'Payment succesfull'
                                              : mechStatus == 0
                                                  ? 'Pending'
                                                  : mechStatus == 1
                                                      ? 'Approved'
                                                      : 'Rejected',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500),
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
          },
        );
      },
    );
  }
}
