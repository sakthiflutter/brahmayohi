import 'dart:convert';

import 'package:brahmayogi/Screens/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'Navigationbarpage.dart';
import 'package:http/http.dart' as http;

class Subscrip extends StatelessWidget {
  const Subscrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: Image(
                image: AssetImage("assets/menu_black_24dp.png"),
                width: 35,
              ),
              onPressed: () => Scaffold.of(context).openDrawer()),
        ),
        centerTitle: true,
        title: Text(
          'Subscription Plans',
          style: TextStyle(fontFamily: 'palatino', fontSize: 20),
        ),
        actions: [
          IconButton(
              icon: Image(
                  image: AssetImage("assets/notifications_black_24dp.png"),
                  width: 22),
              onPressed: () {}),
        ],
        backgroundColor: Color(0xFF947BF5),
      ),
      body: Platinum(),
    );
  }
}

class Platinum extends StatefulWidget {
  @override
  State<Platinum> createState() => _PlatinumState();
}

class _PlatinumState extends State<Platinum> {
  // late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    // _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    // _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SingleChildScrollView(
        child: Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext, index) {
              return InkWell(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/5333978.png",
                        ),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Container(
                          padding: EdgeInsets.all(3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Subscription Plan',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: "palatino",
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna........',
                                style: TextStyle(
                                    fontSize: 12, fontFamily: "palatino"),
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: OutlinedButton(
                                      child: Text(
                                        "Pay",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'palatino',
                                            color: Colors.grey),
                                      ),
                                      onPressed: () {
                                        paymentapi();
                                      },
                                      // onPressed: () {
                                      //   Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const Home()),
                                      //   );
                                      // },
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ))),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Container(
                                    child: OutlinedButton(
                                      child: Text(
                                        "View",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'palatino',
                                            color: Colors.grey),
                                      ),
                                      onPressed: () => showDialog<String>(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          insetPadding: EdgeInsets.only(
                                              right: 10, left: 10),
                                          title: Center(
                                            child: Text(
                                              'Subscription Plan',
                                              style: TextStyle(
                                                  fontFamily: 'palatino'),
                                            ),
                                          ),
                                          content: Text(
                                            'Lorem ipsum dolor sit amet, consetetur sadipscing, elitr',
                                            style: TextStyle(
                                                fontFamily: 'palatino'),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ))),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: 1,
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
          ),
        ),
      );
    });
  }

  var baseurl = 'http://bhramayogi.teckzy.co.in/User_api';
  void paymentapi() async {
    var url = Uri.parse('$baseurl/payment');
    final prefs = await SharedPreferences.getInstance();
    var memberid = prefs.getString('member_id');
    final response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'x-api-key': 'yogi@123'
    }, body: {
      'amount': '1023',
      'member_id': memberid.toString(),
      'payment_type': 'online',
    });
    var data = json.decode(response.body);
    try {
      // _razorpay.open(data);
    } catch (e) {
      debugPrint('Error: e');
    }
    print('sssss' + memberid.toString());
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   print('Success Response: $response');
  //   Get.offAll(() => Home());
  //   Fluttertoast.showToast(msg: 'payment successfull');
  //   /*Fluttertoast.showToast(
  //       msg: "SUCCESS: " + response.paymentId!,
  //       toastLength: Toast.LENGTH_SHORT); */
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   print('Error Response: $response');
  //   Fluttertoast.showToast(msg: 'Payment failed');
  //   /* Fluttertoast.showToast(
  //       msg: "ERROR: " + response.code.toString() + " - " + response.message!,
  //       toastLength: Toast.LENGTH_SHORT); */
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   print('External SDK Response: $response');
  //   /* Fluttertoast.showToast(
  //       msg: "EXTERNAL_WALLET: " + response.walletName!,
  //       toast Length: Toast.LENGTH_SHORT); */
  // }
}
