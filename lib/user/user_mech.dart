import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mech_doc/user/u_m_details.dart';

class UserMech extends StatefulWidget {
  final String? searchQuery;
  final String collectionName;
  const UserMech({super.key, required this.searchQuery, required this.collectionName});

  @override
  State<UserMech> createState() => _UserMechState();
}

class _UserMechState extends State<UserMech> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(widget.collectionName)
          .where('status', isEqualTo: 1)
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
        final data = snapshot.data!.docs.where((doc) {
          String mechLocation = doc['location'].toString().toLowerCase();

          return mechLocation.contains(widget.searchQuery!);
        }).toList();
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var mechIndex = snapshot.data!.docs[index];
            var mechDoc = data[index].data() as Map<String, dynamic>;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UMDetails(mechIndex: mechIndex)));
                },
                child: Card(
                  child: Container(
                    width: 90.w,
                    height: 125.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor('3d495b')),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 70.w,
                              height: 70.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  image: DecorationImage(
                                      image: NetworkImage(mechDoc['profile']))),
                            ),
                            Text(
                              mechDoc['userName'],
                              style: GoogleFonts.poppins(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              mechDoc['experience'],
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            Text(mechDoc['location'],
                                style:
                                    GoogleFonts.poppins(color: Colors.white)),
                            Container(
                              width: 100.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  color: HexColor('#49CD6E'),
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: Center(
                                child: Text(
                                  'Available',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 12.sp),
                                ),
                              ),
                            )
                          ],
                        )
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
