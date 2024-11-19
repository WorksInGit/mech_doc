import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mech_doc/mechanic/request/service_a_r.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechReq1 extends StatefulWidget {
  const MechReq1({super.key});

  @override
  State<MechReq1> createState() => _MechReq1State();
}

class _MechReq1State extends State<MechReq1> {
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
          .where('mechStatus', isEqualTo: 0)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error : ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.grey));
        }
        final doc = snapshot.data!.docs;
        return ListView.builder(
          itemCount: doc.length,
          itemBuilder: (context, index) {
            var reqIndex = snapshot.data!.docs[index];
            var docId = doc[index].id;
            var reqData = doc[index].data() as Map<String, dynamic>;
            Timestamp timestamp = reqData['timestamp'];
            DateTime dateTime = timestamp.toDate();
            String formattedTime = DateFormat('hh:mm a').format(dateTime);
            String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceAR(
                          reqIndex: reqIndex,
                          docId: docId,
                        ),
                      ));
                },
                child: Card(
                  color: HexColor('3d495b'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              Text(
                                reqData['userName'],
                                style:
                                    GoogleFonts.poppins(color: Colors.white),
                              )
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 30.w),
                            child: Column(
                              children: [
                                Text(reqData['userService'],
                                    style: GoogleFonts.poppins(
                                        color: Colors.white)),
                                Text(formattedDate,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white)),
                                Text(formattedTime,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white)),
                                Text(reqData['userPlace'],
                                    style: GoogleFonts.poppins(
                                        color: Colors.white)),
                              ],
                            ),
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
    );
  }
}
