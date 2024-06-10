import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'Forgetpage.dart';
import 'Homepage.dart';
import 'Registerpage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

TextEditingController mobileController = TextEditingController();
TextEditingController passwordController = TextEditingController();

String? name = '';
String? memberid = '';
String? groupid;
String? token;

var baseurl = 'http://bhramayogi.teckzy.co.in/User_api';

loginapi() async {
  var url = Uri.parse('$baseurl/check_login');
  final prefs = await SharedPreferences.getInstance();
  final response = await http.post(url, headers: <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
    'x-api-key': 'yogi@123'
  }, body: {
    'mobile_no': mobileController.text,
    'password': passwordController.text,
    'device_id':token

  });
  var data = json.decode(response.body);
  print('hi' + response.body);

  if (data['status'] == true) {
    // print(data['customer'][0]['name']);
    // print(data['customer'][0]['member_id']);
    // print(data['customer'][0]['group_id']);

    await prefs.setString('name', data['customer'][0]['name'].toString());
    await prefs.setString(
        'member_id', data['customer'][0]['member_id'].toString());
    await prefs.setString(
        'group_id', data['customer'][0]['group_id'].toString());
    await prefs.setString(
        'photo',
        'http://bhramayogi.teckzy.co.in/${data['customer'][0]['photo']}'
            .toString());

    print(prefs.getString('name'.toString()));
    print(prefs.getString('memberdetails'.toString()));
    print(prefs.getString('member_id').toString());
    print(prefs.getString('group_id').toString());

    // var name = prefs.getString('memberdetail');

    name = prefs.getString('name');
    memberid = prefs.getString('member_id');
    groupid = prefs.getString('group_id');

    print('name=======' + name.toString());
    print('memberid=' + memberid.toString());
    print('groupid=' + groupid.toString());

    Get.offAll(() => Home());
    Fluttertoast.showToast(msg: data['message']);
  } else {
    Fluttertoast.showToast(msg: data['message']);
  }
  print(response.body.toString());
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _Logins();
}

class _Logins extends State<Login> {
  bool isHiddenPassword = true;

  @override
  void initState() {
    getToken();
    super.initState();
  }
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();

    setState(() {
      token = token;
    });
    print('thi is the token');
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 36),
                    child: Column(children: [
                      new Image.asset(
                        "assets/WhatsApp Image 2022-08-16 at 10.35.51 AM.jpg",
                        width: 180,
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Brahma Yogi Foundation',
                        style: TextStyle(
                            fontFamily: 'palatino',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
                  ),
                  SizedBox(height: 36),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login',
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: "palatino"),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      height: 50,
                      width: 400,
                      padding: EdgeInsets.all(0),
                      child: TextField(
                          controller: mobileController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                            labelText: 'Mobile Number',
                            labelStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: "palatino",
                                color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ))),
                  SizedBox(height: 18),
                  Container(
                      height: 50,
                      width: 400,
                      padding: EdgeInsets.all(0),
                      child: TextField(
                          controller: passwordController,
                          obscureText: isHiddenPassword,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: "palatino",
                                color: Colors.grey),
                            suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child:
                                    Icon(Icons.visibility, color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ))),
                  SizedBox(height: 8),
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  //     ),
                  //     TextButton(
                  //       child: const Text(
                  //         'Forget Password ?',
                  //         style: TextStyle(
                  //             fontSize: 16,
                  //             fontFamily: "palatino",
                  //             color: Colors.grey),
                  //       ),
                  //       style: ButtonStyle(
                  //         alignment: Alignment.center,
                  //       ),
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => forget()),
                  //         );
                  //       },
                  //     ),
                  //   ],
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  // ),
                  SizedBox(height: 10),
                  Container(
                      height: 60,
                      padding: EdgeInsets.only(),
                      child: Column(children: [
                        OutlinedButton(
                          onPressed: () async {
                            if (mobileController.text.length != 10) {
                              Fluttertoast.showToast(
                                  msg: 'Enter Vaild Mobile Number');
                            } else if (passwordController.text.isEmpty) {
                              Fluttertoast.showToast(msg: 'Enter Password');
                            } else {
                              await loginapi();
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF947BF5)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ))),
                          child: Text(
                            "Submit",
                            softWrap: true,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        )
                      ])),
                  SizedBox(height: 5),
                  Row(
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: 'palatino'),
                      ),
                      TextButton(
                        child: Text(
                          'Create New',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'palatino'),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const registerpage()),
                          );
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              )));
    });
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
