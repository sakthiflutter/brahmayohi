import 'dart:convert';

import 'package:brahmayogi/Screens/Loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  String? privacy;
  privacyapi() async {
    var url = Uri.parse('$baseurl/private_policy');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'x-api-key': 'yogi@123'
    });
    var data = json.decode(response.body);
    if (data != null) {
      setState(() {
        privacy = data["private_policy"];
      });
    } else {}
    print(response.body.toString());
  }

  @override
  void initState() {
    privacyapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple[400],
        title: Text(
          "Privacy Policy",
          style: TextStyle(fontSize: 22.0, fontFamily: "palatino"),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Sizer(builder: (context, orientation, deviceType) {
          return Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            color: Color(0xFFDCE8EE),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  child: privacy != null
                      ? Html(
                          data: privacy,
                          // tagsList: Html.tags..addAll(["bird", "flutter"]),
                          // style: {
                          //     "p": Style(
                          //       backgroundColor:
                          //           Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                          //     ),
                          //   }
                        )
                      : Container(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
