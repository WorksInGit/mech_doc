import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mech_doc/admin/add_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AdminNotification extends StatefulWidget {
  const AdminNotification({super.key});

  @override
  State<AdminNotification> createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
  String? adminId;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    getAdminId();
  }

  Future<String?> getAdminId() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('adminId');

    if (id != null) {
      setState(() {
        adminId = id;
      });
      String? storedImageUrl = preferences.getString('imageUrl');
      if (storedImageUrl != null) {
        setState(() {
          imageUrl = storedImageUrl;
        });
      } else {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('adminLogin')
            .doc(adminId)
            .get();
        if (doc.exists) {
          setState(() {
            imageUrl = doc['profile'];
          });
          preferences.setString('imageUrl', imageUrl!);
        } else {
          print('Doc not found');
        }
      }
    } else {
      print('Admin id not found in sharedpreferences');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 20.w),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 25.r,
                      backgroundImage: adminId != null && imageUrl != null
                          ? NetworkImage(imageUrl!)
                          : AssetImage('assets/icons/person.png')
                              as ImageProvider),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('notification')
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
                final notification = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: notification.length,
                  itemBuilder: (context, index) {
                    var notiData =
                        notification[index].data() as Map<String, dynamic>;
                    Timestamp timestamp = notiData['timestamp'];
                    DateTime dateTime = timestamp.toDate();
                    String formattedTime =
                        DateFormat('hh:mm a').format(dateTime);
                    DateFormat('dd/MM/yyyy').format(dateTime);
                    return Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Card(
                        elevation: 0,
                        color: HexColor('3d495b'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)
                        ),
                        child: ListTile(
                        
                          title: Row(
                            children: [
                              Text(
                                notiData['matter'],
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    formattedTime,
                                    style: GoogleFonts.poppins(
                                        fontSize: 13.sp, color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                          subtitle: Wrap(
                            children: [
                              Text(
                                notiData['content'],
                                style: GoogleFonts.poppins(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          shape: OvalBorder(side: BorderSide(color: Colors.black)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNotification(),
                ));
          },
          child: Icon(EvaIcons.plusCircle, size: 50.sp, color: Colors.black),
        ),
      ),
    );
  }
}
