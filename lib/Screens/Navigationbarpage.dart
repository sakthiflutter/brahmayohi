import 'dart:convert';
import 'dart:io';
import 'package:brahmayogi/Screens/Homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'About.dart';
import 'Changepass.dart';
import 'EditProfile.dart';
import 'Loginpage.dart';
import 'Terms&Conditions.dart';
import 'privacy.dart';
import 'package:http/http.dart' as http;

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidget();
}

class _NavigationDrawerWidget extends State<NavigationDrawerWidget> {
  var size, height, width;
  TextEditingController ImagePickerController = TextEditingController();

  File? _image;
  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 100,
    );
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      Get.back();
      this._image = imageTemporary;
      ImagePickerController.text = _image!.path;
      print(_image!.path);
    });
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        linkUrl:
            'https://play.google.com/store/apps/details?id=com.teckzy.brahmayogi',
        chooserTitle: 'Share BrahmaYogi');
  }

  bool iscontact = false;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    //iscontact = false;

    return Sizer(builder: (context, orientation, deviceType) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.88,
        child: Drawer(
          backgroundColor: Color(0xFFDCE8EE),
          child: Container(
            child: Column(children: [
              Container(
                height: 56,
                color: Color(0xFF947BF5),
              ),
              SizedBox(height: 15),
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(6, 0, 9, 2),
                child: ListTile(
                    leading: IconButton(
                        icon:
                            Image(image: AssetImage("assets/information.png")),
                        onPressed: () {}),
                    title: Text(
                      'About us',
                      style: TextStyle(fontSize: 18, color: Color(0xFF3D50FF)),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => About()),
                      );
                    }),
              ),
              SizedBox(height: 6),
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(6, 0, 9, 2),
                child: ListTile(
                    leading: IconButton(
                        icon: Image( 
                            image:
                                AssetImage("assets/terms-and-conditions.png")),
                        onPressed: () {}),
                    title: Text(
                      'Terms and Conditions',
                      style: TextStyle(fontSize: 18, color: Color(0xFF3D50FF)),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Term()),
                      );
                    }),
              ),
              SizedBox(height: 6),
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(6, 0, 9, 2),
                child: ListTile(
                    leading: IconButton(
                        icon: Image(image: AssetImage("assets/privacy.png")),
                        onPressed: () {}),
                    title: Text(
                      'Privacy Policy',
                      style: TextStyle(fontSize: 18, color: Color(0xFF3D50FF)),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Privacy()),
                      );
                    }),
              ),
              SizedBox(height: 6),
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(6, 0, 9, 2),
                child: ListTile(
                  leading: IconButton(
                      icon: Image(image: AssetImage("assets/share.png")),
                      onPressed: () {}),
                  title: Text(
                    'Share App',
                    style: TextStyle(fontSize: 18, color: Color(0xFF3D50FF)),
                  ),
                  onTap: share,
                ),
              ),
              SizedBox(height: 6),
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(6, 0, 9, 2),
                child: ListTile(
                    leading: IconButton(
                        icon: Image(image: AssetImage("assets/refund.png")),
                        onPressed: () {}),
                    title: Row(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Contact us',
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFF3D50FF)),
                              ),
                              SizedBox(height: 6),
                              if (iscontact)
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'What’s app No: 9385352359',
                                        style: TextStyle(
                                            fontFamily: 'palatino',
                                            fontSize: 12.4),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        'Mail id: ',
                                        style: TextStyle(
                                            fontFamily: 'palatino',
                                            fontSize: 12.4),
                                      ),
                                      Text(
                                        'brahmayogifoundation@gmail.com',
                                        style: TextStyle(
                                            fontFamily: 'palatino',
                                            fontSize: 12.4),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: iscontact
                          ? Icon(Icons.arrow_drop_down_circle_sharp)
                          : Icon(Icons.arrow_drop_down_circle_sharp),
                      onPressed: () {
                        setState(() {
                          if (iscontact) {
                            iscontact = false;
                          } else {
                            iscontact = true;
                          }
                        });
                      },
                    ),
                    onTap: () {}),
              ),
              SizedBox(height: 6),
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(6, 0, 9, 2),
                child: ListTile(
                    leading: IconButton(
                        icon: Image(image: AssetImage("assets/padlock.png")),
                        onPressed: () {}),
                    title: Text(
                      'Change Password',
                      style: TextStyle(fontSize: 18, color: Color(0xFF3D50FF)),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Change()),
                      );
                    }),
              ),
              SizedBox(height: 6),
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(6, 0, 9, 2),
                child: ListTile(
                    leading: IconButton(
                        icon: Image(image: AssetImage("assets/logout (3).png")),
                        onPressed: () {}),
                    title: Text(
                      'Logout',
                      style: TextStyle(fontSize: 18, color: Color(0xFF3D50FF)),
                    ),
                    onTap: () {
                      setState(() {
                        var token = null;
                      });
                      showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content:
                                  const Text('Are you sure you want to exit?'),
                              actions: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color((0xFF947BF5))),
                                  child: const Text(
                                    'No',
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color((0xFF947BF5))),
                                  child: const Text(
                                    'Yes',
                                  ),
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.clear();
                                    Navigator.of(context).pop(true);
                                    Get.offAll(() => Login());
                                  },
                                ),
                              ],
                            );
                          });
                      MObileNOController.clear();
                    }),
              ),
            ]),
          ),
        ),
      );
    });
  }

  var grouplist;
  Future<void> groupdata() async {
    var url = "http://bhramayogi.teckzy.co.in/User_api/update_register";
    var pref = await SharedPreferences.getInstance();
    var memberid = pref.getString('member_id');
    print(memberid);
    var finalurl = Uri.parse(url);
    var res = await http.post(finalurl, headers: <String, String>{
      'X-API-KEY': 'yogi@123',
    }, body: {
      'member_id': memberid.toString(),
    });

    var decodeValue = json.decode(res.body);
    setState(() {
      grouplist = decodeValue['user'];
      print(decodeValue['user']);
      print(grouplist.toString());
    });
  }
}
