import 'dart:convert';

import 'package:brahmayogi/Screens/Loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class Term extends StatefulWidget {
  const Term({Key? key}) : super(key: key);

  @override
  State<Term> createState() => _TermState();
}

class _TermState extends State<Term> {
  String? term;
  aboutapi() async {
    var url = Uri.parse('$baseurl/terms_condition');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'x-api-key': 'yogi@123'
    });
    var data = json.decode(response.body);
    if (data != null) {
      setState(() {
        term = data["terms_condition"];
      });
    } else {}
    print(response.body.toString());
  }

  @override
  void initState() {
    aboutapi();
  }

  bool value = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple[400],
          title: Text(
            "Terms and Conditions",
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
                child: term != null
                    ? Html(
                        data: term,
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
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   padding: EdgeInsets.all(12),
              //   // height: 40,
              //   // width: 40,
              //   color: Colors.white,
              //   child: Row(
              //     children: <Widget>[
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Checkbox(
              //         value: this.value,
              //         onChanged: (o) {
              //           setState(() {
              //             this.value = o!;
              //           });
              //         },
              //       ),
              //       SizedBox(width: 10), //SizedBox
              //       SizedBox(
              //         width: 250,
              //         child: Text(
              //           'I accept and agree to the terms and conditions  ',
              //           style: TextStyle(fontSize: 16.0, color: Colors.red),
              //         ),
              //       ), //Text
              //       //SizedBox
              //
              //       //Checkbox
              //     ], //<Widget>[]
              //   ),
              // )
            ],
          ),
        )));
  }
}
