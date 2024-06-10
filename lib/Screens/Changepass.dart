import 'dart:convert';
import 'package:brahmayogi/Screens/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

var baseurl = 'http://bhramayogi.teckzy.co.in/User_api';
void changeapi(oldpassword, newpassword) async {
  var url = Uri.parse('$baseurl/change_password');
  var prefs = await SharedPreferences.getInstance();
  var customerId = prefs.getString('member_id');
print('this is');
  print(oldpassword);
  print(newpassword);
  final response = await http.post(url, headers: <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
    'x-api-key': 'yogi@123'
  }, body: {
    'member_id': customerId.toString(),
    'old_password': oldpassword,
    'new_password': newpassword,
  });
  var data = json.decode(response.body);
  print(data.toString());
  if (data[0]['status'] == true) {
    OldpasswordController.clear();
    NewpasswordController.clear();
    ConfPasswordController.clear();
    Get.offAll(() => Home());
    Fluttertoast.showToast(msg: data[0]['msg']);
  } else {
    Fluttertoast.showToast(msg: data[0]['msg']);
  }
  print('this is the body');
  print(response.body.toString());
}

TextEditingController OldpasswordController = TextEditingController();
TextEditingController NewpasswordController = TextEditingController();
TextEditingController ConfPasswordController = TextEditingController();

String oldpassword = OldpasswordController.text;
String newpassword = NewpasswordController.text;

class Change extends StatelessWidget {
  const Change({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF947BF5),
        title: Text(
          "Change Password",
          style: TextStyle(fontSize: 22.0, fontFamily: "palatino"),
          textAlign: TextAlign.center,
        ),
      ),
      body: Changepass(),
    );
  }
}

class Changepass extends StatefulWidget {
  Changepass({Key? key}) : super(key: key);

  @override
  State<Changepass> createState() => _Changepassword();
}

class _Changepassword extends State<Changepass> {
  bool isHiddenPassword = true;
  bool isHiddenPassword1 = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                controller: OldpasswordController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    labelText: 'Old Password',
                    labelStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: "palatino",
                        color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)))),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                obscureText: isHiddenPassword,
                controller: NewpasswordController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    labelText: 'New Password',
                    labelStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: "palatino",
                        color: Colors.grey),
                    suffixIcon: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(Icons.visibility, color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)))),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                obscureText: isHiddenPassword1,
                controller: ConfPasswordController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    labelText: 'Confirm Password',
                    labelStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: "palatino",
                        color: Colors.grey),
                    suffixIcon: InkWell(
                        onTap: _togglePasswordView1,
                        child: Icon(Icons.visibility, color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)))),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 130, right: 130),
            child: OutlinedButton(

              // textColor: Colors.grey,
              // color: Colors.white,
              child: Text(
                "Save",
                style: TextStyle(
                    fontSize: 16, fontFamily: 'palatino', color: Colors.white),
              ),
              onPressed: () {
                print('save');
                if (NewpasswordController.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please enter password');
                } else if (NewpasswordController.text.length <= 6&&NewpasswordController.text.length >= 10) {
                  Fluttertoast.showToast(msg: 'Password must be 6 to 10 characters');
                } else if (ConfPasswordController.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please enter confirm password');
                } else if (ConfPasswordController.text.length <= 6 &&ConfPasswordController.text.length >= 6) {
                  Fluttertoast.showToast(msg: 'Please enter confirm password');
                } else if (NewpasswordController.text !=
                    ConfPasswordController.text) {
                  Fluttertoast.showToast(
                      msg: "Password and Confirm password did't match");
                } else  {


                  changeapi(

                    OldpasswordController.text,
                    NewpasswordController.text,
                  );
                }
                // OldpasswordController.clear();
                // NewpasswordController.clear();
                // ConfPasswordController.clear();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF947BF5)),

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

  void _togglePasswordView1() {
    setState(() {
      isHiddenPassword1 = !isHiddenPassword1;
    });
  }
}
