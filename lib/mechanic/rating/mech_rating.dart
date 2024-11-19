import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechRating extends StatefulWidget {
  const MechRating({super.key});

  @override
  State<MechRating> createState() => _MechRatingState();
}

class _MechRatingState extends State<MechRating> {
  double _ratingStar = 0;
  String? mechId;
  @override
  void initState() {
    super.initState();
    _getMechId();
  }

  Future<void> _getMechId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('mechId');
    if (id != null) {
      setState(() {
        mechId = id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Rating',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: HexColor('#222831'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              'The rating given to you',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300, color: Colors.white),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('userRequest')
                    .orderBy('timestamp', descending: true)
                    .where('mechId', isEqualTo: mechId)
                    .where('paymentStatus', isEqualTo: 5)
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
                      var ratingData =
                          doc[index].data() as Map<String, dynamic>;
                      Timestamp timestamp = ratingData['timestamp'];
                      DateTime dateTime = timestamp.toDate();
                      String formattedTime =
                          DateFormat('hh:mm a').format(dateTime);
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(dateTime);
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10),
                        child: Card(
                          child: Container(
                            width: 300.w,
                            height: 130.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: HexColor('3d495b')),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                            radius: 25.r,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: NetworkImage(
                                                ratingData['userProfile'])),
                                        Text(
                                          ratingData['userName'],
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          ratingData['userService'],
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          formattedDate,
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          formattedTime,
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          ratingData['userPlace'],
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Rating',
                                          style: GoogleFonts.poppins(
                                              fontSize: 10.sp,
                                              color: Colors.white),
                                        ),
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          allowHalfRating: true,
                                          itemSize: 17.sp,
                                          initialRating: ratingData['rating'],
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (value) {
                                            setState(() {
                                              _ratingStar = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          ratingData['rating'].toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize: 10.sp,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
