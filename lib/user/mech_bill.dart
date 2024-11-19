import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mech_doc/user/user_payment.dart';
import 'package:mech_doc/user/user_rating.dart';

class MechBill extends StatefulWidget {
  final DocumentSnapshot reqIndex;
  const MechBill({super.key, required this.reqIndex});

  @override
  State<MechBill> createState() => _MechBillState();
}

class _MechBillState extends State<MechBill> {
  double _currentRating = 0;
  @override
  void initState() {
    super.initState();
    _fetchMechData();
    _updateRating();
  }

  String? profileUrl;
  String? mechExp;
  TextEditingController _amountController = TextEditingController();
  Future<void> _fetchMechData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('mechSignUp')
        .doc(widget.reqIndex['mechId'])
        .get();
    setState(() {
      profileUrl = doc['profile'];
      mechExp = doc['experience'];
    });
  }

Future<void> _updatePaymentStatus() async {
  FirebaseFirestore.instance.collection('userRequest').doc(widget.reqIndex.id).update(
    {'paymentStatus': 5}
  );
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserPayment(),));
}

Future<void> _updateRating() async {
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('userRequest').doc(widget.reqIndex.id).get();
  setState(() {
    _currentRating = documentSnapshot['rating'];
  });
}
  @override
  Widget build(BuildContext context) {
    _amountController.text = widget.reqIndex['userAmount'].toString();
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        appBar: AppBar(
          backgroundColor: HexColor('222831'),
          leading: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
          title: Text(
            'Mechanic Bill',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                profileUrl != null
                    ? CircleAvatar(
                        radius: 60.sp,
                        backgroundImage: NetworkImage(profileUrl!),
                      )
                    : CircleAvatar(
                        radius: 60.sp,
                        backgroundColor: Colors.grey,
                      ),
                Text(
                  widget.reqIndex['mechName'],
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(mechExp != null ? mechExp! : 'Loading Experience',
                    style: GoogleFonts.poppins(color: Colors.white)),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 100.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: HexColor('#49CD6E'),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Center(
                    child: Text(
                      'Available',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 13.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      ignoreGestures: true,
                      itemSize: 25.sp,
                      initialRating: _currentRating,
                      minRating: 1,
                      allowHalfRating: true,
                      direction: Axis.horizontal,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) => setState(() {
                        _currentRating = value;
                      }),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserRating(reqIndex: widget.reqIndex),
                              ));
                        },
                        icon: Icon(
                          Iconsax.edit_25,
                          color: Colors.white,
                        ))
                  ],
                ),
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
                      readOnly: true,
                      controller: _amountController,
                      style: GoogleFonts.poppins(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.currency_rupee_sharp,
                            color: Colors.white,
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    )),
                SizedBox(
                  height: 100.h,
                ),
                GestureDetector(
                  onTap: () {
                    _updatePaymentStatus();
                  },
                  child: Container(
                    width: 200.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: HexColor('#2357D9'),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                      child: Text(
                        'Payment',
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
      ),
    );
  }
}
