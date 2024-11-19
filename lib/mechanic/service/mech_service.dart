import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechService extends StatefulWidget {
  const MechService({super.key});

  @override
  State<MechService> createState() => _MechServiceState();
}

class _MechServiceState extends State<MechService> {
  @override
  void initState() {
    super.initState();
    _loadMechId();
  }

  String? mechId;

  Future<void> _loadMechId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('mechId');

    setState(() {
      mechId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#222831'),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Service',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: HexColor('#3d495b'),
        ),
        body: Card(
          margin: EdgeInsets.all(30).r,
          color: HexColor('3d495b'),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('mechServices')
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
                  var mechIndex = snapshot.data!.docs[index];
                  var serviceData = doc[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              serviceData['service'],
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon:
                                    Icon(EvaIcons.trash2, color: Colors.white))
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddService();
              },
            );
          },
          child: Icon(
            EvaIcons.plusCircle,
            color: Colors.black,
            size: 45.sp,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0.r),
              side: BorderSide(color: Colors.black)),
          elevation: 0,
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  @override
  void initState() {
    super.initState();
    _loadMechId();
  }

  String? mechId;
  TextEditingController _serviceController = TextEditingController();
  Future<void> _loadMechId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('mechId');

    setState(() {
      mechId = id;
    });
  }

  Future<void> _addService() async {
    FirebaseFirestore.instance
        .collection('mechServices')
        .add({'service': _serviceController.text, 'mechId': mechId});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: HexColor('#3d495b'),
      title: Text(
        'Add service',
        style: GoogleFonts.poppins(color: Colors.white),
      ),
      actions: <Widget>[
        TextField(
          controller: _serviceController,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.r)),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 150.h,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              _addService();
            },
            child: Container(
              width: 140.w,
              height: 45.h,
              decoration: BoxDecoration(
                  color: HexColor('#2357D9'),
                  borderRadius: BorderRadius.circular(10.r)),
              child: Center(
                child: Text(
                  'Add',
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
