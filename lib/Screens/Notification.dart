import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class Notifica extends StatelessWidget {
  const Notifica({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notification',
          style: TextStyle(fontFamily: 'palatino', fontSize: 20),
        ),
        backgroundColor: Color(0xFF947BF5),
      ),
      body: Notifications(),
    );
  }
}

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _Notifica();
}

class _Notifica extends State<Notifications> {
  @override
  void initState() {
    getnotification();
    super.initState();
  }

  var notification = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(

        itemCount: notification.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              trailing: SelectableText(
              DateFormat.yMd().add_jms().format(DateTime.parse('${notification[index]['created_dt']!}'))),
                subtitle:
                notification[index]['sender']=='admin' ?Text(' You have received a '+notification[index]['type'].toString()+' from admin'):
                Text(' You have received a '+notification[index]['type'].toString()+' message in your group from admin '),
                // leading: Icon(Icons.list),
                title:notification[index]['sender']=='admin' ?
                const Text(
                  'Admin  Reply',
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ):const Text(
                  'Group  Message',
                  style: TextStyle(color: Colors.green, fontSize: 15),
                )),
          );
        });
  }

  Future<void> getnotification() async {
    var url = "http://bhramayogi.teckzy.co.in/User_api/notification";
    var pref = await SharedPreferences.getInstance();
    // var memberid = pref.getString('member_id');
    var grpid = pref.getString('member_id');
    print({
      'group_id': grpid.toString(),
      // 'msg': admin_msgs,
      // 'msg': 'Hiii'
    });
    var finalurl = Uri.parse(url);
    var res = await http.post(finalurl, headers: <String, String>{
      'x-api-key': 'yogi@123',
    },
        body: {
      'member_id': grpid.toString(),

    });

    var decodeValue = json.decode(res.body);
    print(decodeValue);
    setState(() {
      notification = decodeValue['data'];
         notification.sort((a, b)=> a['created_dt'].compareTo(b['created_dt']));
      notification= notification.reversed.toList();
    });
  }

  Future<void> adminmsg() async {
    var url = "http://bhramayogi.teckzy.co.in/User_api/admin_msg";
    var pref = await SharedPreferences.getInstance();
    // var memberid = pref.getString('member_id');
    var grpid = pref.getString('group_id');
    var finalurl = Uri.parse(url);
    var res = await http.post(finalurl, headers: <String, String>{
      'X-API-KEY': 'yogi@123',
    }, body: {
      'member_id': grpid.toString(),
      // 'msg': admin_msgs,
      // 'msg': 'Hiii'
    });

    var decodeValue = json.decode(res.body);
    setState(() {
      notification = decodeValue['data'];
    });
  }
}
