import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'GroupMsg.dart';

class message extends StatelessWidget {
  const message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF947BF5),
        title: Text(
          'Group Message',
          style: TextStyle(fontSize: 22.0, fontFamily: "palatino"),
          textAlign: TextAlign.center,
        ),
      ),
      body: grpmsg(),
    );
  }
}

var group_list = [];

class grpmsg extends StatefulWidget {
  const grpmsg({Key? key}) : super(key: key);

  @override
  State<grpmsg> createState() => _grpmsgState();
}

class _grpmsgState extends State<grpmsg> {
  @override
  void initState() {
    groupdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext, index) {
          return InkWell(
            onTap: () {
              print(group_list[index]['group_id']);
              Get.to(() => Group(
                    name: group_list[index]['group_name']!,
                    profileImg: group_list[index]['profile']!,
                    grpid: group_list[index]['group_id']!,
                  ));
            },
            child: Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(6),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(group_list[index]['profile']!),
                  radius: 30,
                  backgroundColor: Color(0xFF947BF5),
                ),
                title: Text(
                  group_list[index]['group_name']!,
                  style: TextStyle(fontSize: 16, fontFamily: "palatino"),
                ),
                subtitle: Text(
                  group_list[index]["message_type"] == 'image'
                      ? 'Image'
                      : group_list[index]["last_message"]!,
                  style: TextStyle(fontSize: 14, fontFamily: "palatino"),
                ),
              ),
            ),
          );
        },
        itemCount: group_list.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Future<void> groupdata() async {
    var url = "http://bhramayogi.teckzy.co.in/User_api/get_group";
    var pref = await SharedPreferences.getInstance();
    var memberid = pref.getString('member_id');
    print(memberid);
    var finalurl = Uri.parse(url);
    var res = await http.post(finalurl, headers: <String, String>{
      'X-API-KEY': 'yogi@123',
    }, body: {
      'member_id': memberid.toString(),
    });

    var decodeValue = json.decode(res.body);
    setState(() {
      group_list = decodeValue['datas']['group_list'];
    });
  }
}
