import 'dart:convert';
import 'package:brahmayogi/Screens/Registerpage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'Forgetpage.dart';
import 'Homepage.dart';
import 'package:http/http.dart' as http;

import 'Loginpage.dart';

var baseurl = 'http://bhramayogi.teckzy.co.in/User_api';
void Resetapi(password) async {
  var url = Uri.parse('$baseurl/change_forgot_password');
  final response = await http.post(url, headers: <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
    'x-api-key': 'yogi@123'
  }, body: {
    'mobile_no': mobileVal,
    'password': password,
  });
  var data = json.decode(response.body);
  print('ssssss' + MObileNOController.text);
  if (data[0]['status'] == true) {
    Get.offAll(() => Login());
    Fluttertoast.showToast(msg: data[0]['msg']);
  } else {
    Fluttertoast.showToast(msg: data[0]['msg']);
  }
  print(response.body.toString());
}

class Resetpass extends StatelessWidget {
  const Resetpass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF947BF5),
        title: Text(
          "Reset Password",
          style: TextStyle(fontSize: 22.0, fontFamily: "palatino"),
          textAlign: TextAlign.center,
        ),
      ),
      body: resetbody(),
    );
  }
}

class resetbody extends StatefulWidget {
  @override
  State<resetbody> createState() => _resetbodyState();
}

class _resetbodyState extends State<resetbody> {
  TextEditingController PasswordController = TextEditingController();
  TextEditingController ConfirmpasswordController = TextEditingController();
  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                controller: PasswordController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    labelText: 'New password',
                    labelStyle: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "palatino",
                        color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)))),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                controller: ConfirmpasswordController,
                obscureText: isHiddenPassword,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    labelText: 'Confirm password',
                    labelStyle: TextStyle(
                        fontFamily: "palatino",
                        color: Colors.grey,
                        fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(Icons.visibility, color: Colors.grey)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)))),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 140, right: 140),
            child: OutlinedButton(
              child: Text(
                "Save",
                style: TextStyle(
                    fontFamily: 'palatino',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (PasswordController.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please enter password');
                } else if (PasswordController.text.length != 6) {
                  Fluttertoast.showToast(msg: 'Password must be 6 characters');
                } else if (ConfirmpasswordController.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please enter confirm password');
                } else if (ConfirmpasswordController.text.length != 6) {
                  Fluttertoast.showToast(msg: 'Please enter confirm password');
                } else if (PasswordController.text !=
                    ConfirmpasswordController.text) {
                  Fluttertoast.showToast(
                      msg: "Password and Confirm password did't match");
                } else {
                  Resetapi(
                    PasswordController.text,
                  );
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF947BF5)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ))),
            ),
          ),
        ],
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
