import 'dart:convert';

import 'package:brahmayogi/Screens/Loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  String? about;
  aboutapi() async {
    var url = Uri.parse('$baseurl/about');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'x-api-key': 'yogi@123'
    });
    var data = json.decode(response.body);
    if (data != null) {
      setState(() {
        about = data["about"];
      });
    } else {}
    print(response.body.toString());
  }

  @override
  void initState() {
    aboutapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple[400],
          title: Text(
            "About Us",
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
                child: about != null
                    ? Html(
                        data: about,
                        // tagsList: Html.tags..addAll(["bird", "flutter"]),
                        // style: {
                        //     "p": Style(
                        //         fontSize: FontSize(6), fontFamily: "palatino"
                        // backgroundColor:
                        //     Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                        //         ),
                        //   }
                      )
                    : Container(),
              ),
            ],
          ),
        )));
  }
}
