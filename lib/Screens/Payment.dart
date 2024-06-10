import 'dart:convert';
import 'package:brahmayogi/Screens/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Loginpage.dart';

class payment extends StatelessWidget {
  const payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF947BF5),
        title: Text(
          'Payment',
          style: TextStyle(fontSize: 22, fontFamily: 'palatino'),
        ),
      ),
      body: _payment(),
    );
  }
}

class _payment extends StatefulWidget {
  const _payment({Key? key}) : super(key: key);

  @override
  State<_payment> createState() => __paymentState();
}

class __paymentState extends State<_payment> {
  bool loading = false;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: loading == true
          ? SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 12)
                          ],
                        ),
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12),
                                              child: Text(
                                                'Bank details',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: "palatino",
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
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
                                                          fontFamily:
                                                              'palatino',
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  child: SizedBox(
                                                    child: Container(
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        height:50,
                                                        child:SelectableText(paymendetail!=null?paymendetail[
                                                        'google_pay_name']:'',style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily: 'palatino',
                                                            fontWeight:
                                                            FontWeight.bold
                                                        ),),

                                                        decoration: BoxDecoration(

                                                          border:
                                                          Border.all(

                                                              color:
                                                              Color(0xFFF6F6F6),
                                                              width: 3.0),
                                                        ),


                                                      ),
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
                                                        fontFamily: 'palatino',
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: SizedBox(
                                              child: Container(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height:50,
                                                  child:SelectableText(paymendetail!=null?paymendetail[
                                                  'google_pay_number']:'',style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'palatino',
                                                      fontWeight:
                                                      FontWeight.bold),),

                                                  decoration: BoxDecoration(

                                                      border:
                                                             Border.all(

                                                            color:
                                                                Color(0xFFF6F6F6),
                                                            width: 3.0),
                                                      ),


                                                ),
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
                                                        fontFamily: 'palatino',
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: SizedBox(
                                                  child: Container(
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      height:50,
                                                      child:SelectableText(paymendetail!=null?paymendetail[
                                                      'phonepe_name']:'',style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: 'palatino',
                                                          fontWeight:
                                                          FontWeight.bold),),

                                                      decoration: BoxDecoration(

                                                        border:
                                                        Border.all(

                                                            color:
                                                            Color(0xFFF6F6F6),
                                                            width: 3.0),
                                                      ),


                                                    ),
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
                                                        fontFamily: 'palatino',
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: SizedBox(
                                                  child: Container(
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      height:50,
                                                      child:SelectableText(paymendetail!=null? paymendetail[
                            'phonepe_number']:'',style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: 'palatino',
                                                          fontWeight:
                                                          FontWeight.bold
                                                      ),),

                                                      decoration: BoxDecoration(

                                                        border:
                                                        Border.all(

                                                            color:
                                                            Color(0xFFF6F6F6),
                                                            width: 3.0),
                                                      ),


                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12),
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
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          '(or)',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "palatino",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 12)
                          ],
                        ),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Column(
                                      children: [
                                        SizedBox(height: 12),
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
                                                        fontFamily: 'palatino',
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height:50,
                                                  child:SelectableText(paymendetail[
                            'account_holder_name']??''
                                                    ,style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'palatino',
                                                      fontWeight:
                                                      FontWeight.bold
                                                  ),),

                                                  decoration: BoxDecoration(

                                                    border:
                                                    Border.all(

                                                        color:
                                                        Color(0xFFF6F6F6),
                                                        width: 3.0),
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
                                                        fontFamily: 'palatino',
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height:50,
                                                  child:SelectableText(paymendetail[
                                                  'account_number']??''
                                                    ,style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'palatino',
                                                        fontWeight:
                                                        FontWeight.bold
                                                    ),),

                                                  decoration: BoxDecoration(

                                                    border:
                                                    Border.all(

                                                        color:
                                                        Color(0xFFF6F6F6),
                                                        width: 3.0),
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
                                                        fontFamily: 'palatino',
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height:50,
                                                  child:SelectableText(paymendetail[
                                                  'bank_name']??''
                                                    ,style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'palatino',
                                                        fontWeight:
                                                        FontWeight.bold
                                                    ),),

                                                  decoration: BoxDecoration(

                                                    border:
                                                    Border.all(

                                                        color:
                                                        Color(0xFFF6F6F6),
                                                        width: 3.0),
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
                                                        fontFamily: 'palatino',
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height:50,
                                                  child:SelectableText(paymendetail[
                                                  'bank_branch']??''
                                                    ,style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'palatino',
                                                        fontWeight:
                                                        FontWeight.bold
                                                    ),),

                                                  decoration: BoxDecoration(

                                                    border:
                                                    Border.all(

                                                        color:
                                                        Color(0xFFF6F6F6),
                                                        width: 3.0),
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
                                                        fontFamily: 'palatino',
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height:50,
                                                  child:SelectableText(paymendetail[
                                                  'ifsc_code']??''
                                                    ,style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'palatino',
                                                        fontWeight:
                                                        FontWeight.bold
                                                    ),),

                                                  decoration: BoxDecoration(

                                                    border:
                                                    Border.all(

                                                        color:
                                                        Color(0xFFF6F6F6),
                                                        width: 3.0),
                                                  ),


                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12),
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
                    SizedBox(height: 12),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void initState() {
    paydetailsapi();
  }

  var paymendetail;
  Future<void> paydetailsapi() async {
    var url = Uri.parse('$baseurl/payment_details');
    var pref = await SharedPreferences.getInstance();
    var paydetails = pref.getString('member_id');
    print(paydetails.toString());
    var res = await http.post(url, headers: <String, String>{
      'X-API-KEY': 'yogi@123',
    }, body: {
      'reg_id': paydetails.toString(),
    });
    print(res.body);
    var decodeValue = json.decode(res.body);
    print(9786);

    print(decodeValue);
    setState(() {
      paymendetail = decodeValue;
      loading = true;
    });
  }
}
