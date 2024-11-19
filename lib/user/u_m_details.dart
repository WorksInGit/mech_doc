import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UMDetails extends StatefulWidget {
  final DocumentSnapshot mechIndex;
  const UMDetails({super.key, required this.mechIndex});

  @override
  State<UMDetails> createState() => _UMDetailsState();
}

class _UMDetailsState extends State<UMDetails> {
  String? mechId;
  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  final List<String> services = [];
  TextEditingController _placeController = TextEditingController();
  String? selectedValue;
  String? userUsername;
  String? userProfile;
  String? userService;
  String? userPhoneNo;
  String? userId;
  Future<void> _getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? id = await preferences.getString('userLoginId');

    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('userSignUp').doc(id).get();
    if (doc.exists) {
      setState(() {
        userUsername = doc['userName'];
        userProfile = doc['profile'];
        userPhoneNo = doc['phoneNumber'];
        userId = id;
      });
      setState(() {
        mechId = widget.mechIndex.id;
      });
  _fetchService();
      print(userUsername);
      print(selectedValue);
      print(userProfile);
      print(mechId);
      print(userPhoneNo);
    }
  
  }
  Future<void> _fetchService() async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('mechServices')
          .where('mechId', isEqualTo: mechId)
          .get();
      setState(() {
        services.clear();
        services.addAll(querySnapshot.docs
            .map((doc) => doc['service'].toString())
            .toList());
      });
    }
  Future<void> _addUserReq() async {
    FirebaseFirestore.instance.collection('userRequest').add({
      'userName': userUsername,
      'userProfile': userProfile,
      'userService': selectedValue,
      'userPlace': _placeController.text,
      'timestamp': FieldValue.serverTimestamp(),
      'phoneNumber': userPhoneNo,
      'mechPhoneNumber': widget.mechIndex['phoneNumber'],
      'paymentStatus': 0,
      'mechStatus': 0,
      'mechId': mechId,
      'userAmount': 0,
      'rejectReason': '',
      'userId': userId,
      'mechName': widget.mechIndex['userName'],
      'rating': 0.5
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String username = widget.mechIndex['userName'];
    String phoneNo = widget.mechIndex['phoneNumber'];
    String profileUrl = widget.mechIndex['profile'];
    String experience = widget.mechIndex['experience'];

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('222831'),
        appBar: AppBar(
          backgroundColor: HexColor('222831'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
              )),
          title: Text(
            'Needed service',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 130.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      image: DecorationImage(
                          image: profileUrl.isNotEmpty
                              ? NetworkImage(profileUrl)
                              : AssetImage('assets/icons/buisness_man.png'))),
                ),
                Text(
                  username,
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(phoneNo, style: GoogleFonts.poppins(color: Colors.white)),
                Text(experience,
                    style: GoogleFonts.poppins(color: Colors.white)),
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
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Text(
                        'Add needed service',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: HexColor('3d495b'),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButton(
                            hint: Text(
                              'Select service',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            dropdownColor: HexColor('3d495b'),
                            underline: SizedBox.shrink(),
                            icon: Padding(
                              padding: EdgeInsets.only(left: 75.w),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ),
                            value: selectedValue,
                            items: services.map((String service) {
                              return DropdownMenuItem(
                                child: Text(
                                  service,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.sp, color: Colors.white),
                                ),
                                value: service,
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue;
                              });
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 23.sp,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
              
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30.w,
                    ),
                    Text(
                      'Place',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Padding(
                    padding: EdgeInsets.only(right: 35.w),
                    child: TextFormField(
                      controller: _placeController,
                      style: GoogleFonts.poppins(color: Colors.white),
                      maxLines: 2,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: HexColor('3d495b'),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                GestureDetector(
                  onTap: () {
                    _addUserReq();
                  },
                  child: Container(
                    width: 200.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: HexColor('#2357D9'),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                      child: Text(
                        'Request',
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
            ),
          ),
        ),
      ),
    );
  }
}
