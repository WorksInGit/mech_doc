import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mech_doc/user/mech_bill.dart';
import 'package:mech_doc/user/mech_failed.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRequest extends StatefulWidget {
  const UserRequest({super.key});

  @override
  State<UserRequest> createState() => _UserRequestState();
}

class _UserRequestState extends State<UserRequest> {
  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  int? mechStatus;
  int? paymentStatus;
  String? userId;
  Future<void> _getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('userLoginId');
    if (id != null) {
      setState(() {
        userId = id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('userRequest')
          .where('userId', isEqualTo: userId)
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
            var reqData = doc[index].data() as Map<String, dynamic>;
            var reqIndex = snapshot.data!.docs[index];
            Timestamp timestamp = reqData['timestamp'];
            DateTime dateTime = timestamp.toDate();
            String? formattedTime = DateFormat('hh mm a').format(dateTime);
            String? formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
            mechStatus = reqData['mechStatus'];
            paymentStatus = reqData['paymentStatus'];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
              child: GestureDetector(
                onTap: () {
                  reqData['paymentStatus'] == 3
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MechBill(reqIndex: reqIndex),
                          ))
                      : reqData['paymentStatus'] == 4
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MechFailed(reqIndex: reqIndex),
                              ))
                          : reqData['paymentStatus'] == 5
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
                                                  'assets/animations/Fitness Dancer.json'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'The payment have successfully completed',
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
                              : mechStatus == 0
                                  ? showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 150.h,
                                              horizontal: 15.w),
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
                                                      'assets/animations/Security Shield.json'),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Text(
                                                    'Wait for the approval of the admin',
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
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.grey)))
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : mechStatus == 1
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
                                                          'assets/animations/Constructor.json'),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Text(
                                                        'Work have not been completed yet',
                                                        style:
                                                            GoogleFonts.poppins(
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
                                                        Navigator.pop(context);
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
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Text(
                                                        'Your request have been rejected',
                                                        style:
                                                            GoogleFonts.poppins(
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
                                                        Navigator.pop(context);
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
                child: Card(
                  child: Container(
                    width: 90.w,
                    height: 125.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor('3d495b')),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reqData['mechName'],
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
                                  reqData['userService'],
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 40.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: paymentStatus == 5 ? 150.w : 100.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
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
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.none,
                                    child: Text(
                                      paymentStatus == 3
                                          ? 'Pay'
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
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
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
