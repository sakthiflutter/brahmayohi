import 'dart:convert';

import 'package:brahmayogi/Screens/Loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

TextEditingController g_paynamectrl = TextEditingController();
TextEditingController g_paynoctrl = TextEditingController();
TextEditingController phonepename_ctrl = TextEditingController();
TextEditingController phonepeno_ctrl = TextEditingController();
TextEditingController accountnamectrl = TextEditingController();
TextEditingController accountnoctrl = TextEditingController();
TextEditingController namebankctrl = TextEditingController();
TextEditingController bankbranchctrl = TextEditingController();
TextEditingController ifscctrl = TextEditingController();
void refundaccountapi() async {
  print('enter into refundaccountapi ');
  var url = Uri.parse('$baseurl/refund');
  var request = http.MultipartRequest('POST', url);
  var pref = await SharedPreferences.getInstance();
  var memberid = pref.getString('member_id');
  request.headers.addAll(
    {
      "Content-type": "application/x-www-form-urlencoded",
      'x-api-key': 'yogi@123'
    },
  );
  request.fields['member_id'] = memberid.toString();
  request.fields['google_pay_name'] = g_paynamectrl.text;
  request.fields['google_pay_number'] = g_paynoctrl.text;
  request.fields['phone_pay_name'] = phonepename_ctrl.text;
  request.fields['phone_pay_number'] = phonepeno_ctrl.text;
  request.fields['customer_name'] = accountnamectrl.text;
  request.fields['account_number'] = accountnoctrl.text;
  request.fields['name_of_bank'] = namebankctrl.text;
  request.fields['bank_branch'] = bankbranchctrl.text;
  request.fields['ifsc_code'] = ifscctrl.text;
  var response = await request.send();
  final respStr = await response.stream.bytesToString();
  var data = json.decode(respStr);
  if (data['status'] == true) {
    Fluttertoast.showToast(msg: data['msg']);
  } else {
    Fluttertoast.showToast(msg: data['msg']);
  }
  // g_paynamectrl.clear();
  // g_paynoctrl.clear();
  // phonepename_ctrl.clear();
  // phonepeno_ctrl.clear();
  // accountnamectrl.clear();
  // accountnoctrl.clear();
  // namebankctrl.clear();
  // bankbranchctrl.clear();
  // ifscctrl.clear();
}

class Refund extends StatefulWidget {
  const Refund({Key? key}) : super(key: key);

  @override
  State<Refund> createState() => _RefundState();
}

class _RefundState extends State<Refund> {
  var size, height, width;
  bool isChecked = false;
  String? refund;
  refundapi() async {
    var url = Uri.parse('$baseurl/refund');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'x-api-key': 'yogi@123'
    });
    var data = json.decode(response.body);
    if (data != null) {
      setState(() {
        refund = data["refund"];
      });
    } else {}
    print(response.body.toString());
  }

  @override
  void initState() {
    refundapi();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.deepPurple[400],
            title: Text(
              "Refund Policy",
              style: TextStyle(fontSize: 22.0, fontFamily: "palatino"),
              textAlign: TextAlign.center,
            ),
          ),
          body: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            color: Color(0xFFDCE8EE),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  color: Colors.white,
                  child: refund != null
                      ? Html(
                          data: refund,
                        )
                      : Container(),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  color: Colors.white,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Bank details',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Exo2",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 12),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Google Pay Name',
                                                style: TextStyle(
                                                    fontFamily: 'Exo2',
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          child: TextField(
                                            controller: g_paynamectrl,
                                            decoration: InputDecoration(
                                                hintText: '',
                                                hintStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'palatino',
                                                    fontWeight:
                                                        FontWeight.bold),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 3.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 3.0),
                                                )),
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Google Pay Number',
                                              style: TextStyle(
                                                  fontFamily: 'Exo2',
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        child: TextField(
                                          controller: g_paynoctrl,
                                          decoration: InputDecoration(
                                              hintText: '',
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'palatino',
                                                  fontWeight: FontWeight.bold),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFF6F6F6),
                                                    width: 3.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFF6F6F6),
                                                    width: 3.0),
                                              )),
                                        ),
                                      )),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Phonepe Name',
                                              style: TextStyle(
                                                  fontFamily: 'Exo2',
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        child: TextField(
                                          controller: phonepename_ctrl,
                                          decoration: InputDecoration(
                                              hintText: '',
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'palatino',
                                                  fontWeight: FontWeight.bold),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFF6F6F6),
                                                    width: 3.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFF6F6F6),
                                                    width: 3.0),
                                              )),
                                        ),
                                      )),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Phonepe Number',
                                              style: TextStyle(
                                                  fontFamily: 'Exo2',
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        child: TextField(
                                          controller: phonepeno_ctrl,
                                          decoration: InputDecoration(
                                              hintText: '',
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'palatino',
                                                  fontWeight: FontWeight.bold),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFF6F6F6),
                                                    width: 3.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFF6F6F6),
                                                    width: 3.0),
                                              )),
                                        ),
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                    itemCount: 1,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      '(or)',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Exo2",
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  color: Colors.white,
                  child: Container(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            children: [
                              ListTile(
                                title: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Name',
                                                style: TextStyle(
                                                    fontFamily: 'Exo2',
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          child: TextField(
                                            controller: accountnamectrl,
                                            decoration: InputDecoration(
                                                hintText: '',
                                                hintStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'palatino',
                                                    fontWeight:
                                                        FontWeight.bold),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 3.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 3.0),
                                                )),
                                          ),
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Account Number',
                                                style: TextStyle(
                                                    fontFamily: 'Exo2',
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          child: TextField(
                                            controller: accountnoctrl,
                                            decoration: InputDecoration(
                                                hintText: '',
                                                hintStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'palatino',
                                                    fontWeight:
                                                        FontWeight.bold),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 3.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 3.0),
                                                )),
                                          ),
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Name of the bank',
                                                style: TextStyle(
                                                    fontFamily: 'Exo2',
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          child: TextField(
                                            controller: namebankctrl,
                                            decoration: InputDecoration(
                                                hintText: '',
                                                hintStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'palatino',
                                                    fontWeight:
                                                        FontWeight.bold),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 3.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 3.0),
                                                )),
                                          ),
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Bank Branch',
                                                style: TextStyle(
                                                    fontFamily: 'Exo2',
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          child: TextField(
                                            controller: bankbranchctrl,
                                            decoration: InputDecoration(
                                                hintText: '',
                                                hintStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'palatino',
                                                    fontWeight:
                                                        FontWeight.bold),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 3.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 3.0),
                                                )),
                                          ),
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'IFSC Code',
                                                style: TextStyle(
                                                    fontFamily: 'Exo2',
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          child: TextField(
                                            controller: ifscctrl,
                                            decoration: InputDecoration(
                                                hintText: '',
                                                hintStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'palatino',
                                                    fontWeight:
                                                        FontWeight.bold),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 3.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 3.0),
                                                )),
                                          ),
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 16),

                                    SizedBox(height: 20),
                                    Container(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          refundaccountapi();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Color(0xFF947BF5) // foreground
                                            ),
                                        // color: Color(0xFF947BF5),
                                        child: Text('Send',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontFamily: 'palatino')),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                        );
                      },
                      itemCount: 1,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                ),
              ],
            ),
          ))),
    );
  }
}
