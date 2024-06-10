import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sizer/sizer.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'Resetpage.dart';
import 'package:http/http.dart' as http;

var baseurl = 'http://bhramayogi.teckzy.co.in/User_api';
var otpvalue = '';
var resendval = true;
final TextEditingController otp = TextEditingController();
var mobileVal = '';

void forgotPasswordapi(mobile) async {
  var url = Uri.parse('$baseurl/forgot_password');
  final response = await http.post(url, headers: <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
    'x-api-key': 'yogi@123'
  }, body: {
    'mobile_no': mobile,
  });
  var data = json.decode(response.body);
  print(response.body.toString());
  if (data[0]['status'] == true) {
    otpvalue = data[0]['otp_no'];
    mobileVal = mobile;
    Fluttertoast.showToast(msg: otpvalue = data[0]['otp_no']);
    Get.bottomSheet(
      Container(
        height: 360,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: new SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(25.0),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "OTP Verification",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "palatino",
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: Get.width * .8,
                        child: PinPut(
                            controller: otp,
                            onChanged: (o) {
                              if (o.length == 6) {
                                if (otpvalue == otp.text) {
                                  Get.to(() => Resetpass());
                                } else {
                                  Fluttertoast.showToast(msg: 'Invalid Otp');
                                }
                                otp.clear();
                              }
                            },
                            keyboardType: TextInputType.number,
                            submittedFieldDecoration:
                                _pinPutDecoration.copyWith(
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                            followingFieldDecoration:
                                _pinPutDecoration.copyWith(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            selectedFieldDecoration: _pinPutDecoration,
                            fieldsCount: 6),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(25.0),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "We Have sent an OTP to your",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "palatino",
                              color: Colors.grey[400]),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "mobile number",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "palatino",
                              color: Colors.grey[400]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          resendval ? 'Resend' : '',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "palatino",
                              color: Colors.black),
                        ),
                        onPressed: () {
                          Get.back();
                          forgotPasswordapi(mobile);
                        },
                      ),
                      Text(
                        "OTP  0:",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "palatino",
                            color: Colors.grey),
                      ),
                      Countdown(
                        seconds: 30,
                        build: (BuildContext context, double time) => Text(
                            time.toString().split('.')[0],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                        interval: Duration(milliseconds: 100),
                        onFinished: () {
                          resendval = true;
                        },
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    height: 60,
                    padding: EdgeInsets.only(),
                    child: Column(children: [
                      OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF947BF5)),
                          ),
                          onPressed: () {
                            if (otpvalue == otp.text) {
                              print('otp correct');
                              Get.to(() => Resetpass());
                            } else {
                              Fluttertoast.showToast(msg: 'Invalid Otp');
                            }
                            otp.clear();
                          },
                          child: Text(
                            "Verify",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ))
                    ])),
              ],
            ),
          ),
        ),
      ),
      enableDrag: false,
    );
  } else {
    Fluttertoast.showToast(msg: data[0]['msg']);
  }
  print(response.body.toString());
}

class forget extends StatelessWidget {
  const forget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF947BF5),
        title: Text(
          "Forget Password",
          style: TextStyle(fontSize: 22.0, fontFamily: "palatino"),
          textAlign: TextAlign.center,
        ),
      ),
      body: forgetpage(),
    );
  }
}

class forgetpage extends StatefulWidget {
  forgetpage({Key? key}) : super(key: key);

  @override
  State<forgetpage> createState() => _forgetpages();
}

class _forgetpages extends State<forgetpage> {
  TextEditingController MObileNOController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Container(
          padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child: ListView(key: _formkey, children: <Widget>[
            SizedBox(height: 10),
            Container(
                height: 50,
                width: 400,
                padding: EdgeInsets.all(0),
                child: TextField(
                    controller: MObileNOController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Mobile Number',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 30),
            Container(
              child: Column(
                children: [
                  OutlinedButton(
                    child: Text(
                      "Get OTP",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.white),
                    ),
                    onPressed: () {
                      if (MObileNOController.text.length != 10) {
                        Fluttertoast.showToast(
                            msg: 'Enter valid Mobile Number');
                      } else {
                        forgotPasswordapi(MObileNOController.text);
                      }
                      print(MObileNOController);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF947BF5)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ))),
                  ),
                ],
              ),
            ),
          ]));
    });
  }
}

BoxDecoration get _pinPutDecoration {
  return BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 3,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  );
}
