import 'dart:convert';
import 'dart:io';
import 'package:brahmayogi/Screens/Loginpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'AdminMsg.dart';
import 'EditProfile.dart';
import 'Message.dart';
import 'Navigationbarpage.dart';
import 'Payment.dart';
import 'PaymentHistory.dart';
import 'Notification.dart';
import 'package:http/http.dart' as http;
import 'Refund.dart';
import 'pay_screen_share.dart';

var convoList = [];
var detailList;
var memList;
var profiledetails;
var grpList;
var profile='';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          drawer: NavigationDrawerWidget(),
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    'assets/WhatsApp Image 2022-08-16 at 10.35.51 AM.jpg',
                    width: 40),
                const SizedBox(width: 12),
                const Text('Brahma Yogi',
                    style: TextStyle(
                        fontFamily: 'palatino',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ],
            ),
            leading: Builder(
              builder: (context) => IconButton(
                  icon: const Image(
                    image: AssetImage("assets/menu_black_24dp.png"),
                    width: 35,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer()),
            ),
            actions: [
              Column(
                children: [
                  IconButton(
                      icon: Image(
                          image:
                              AssetImage("assets/notifications_black_24dp.png"),
                          width: 22),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Notifica()),
                        );
                      }),
                ],
              ),
            ],
            backgroundColor: Color(0xFF947BF5),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => admin()),
              );
            },
            label: Text(
              "Contact Admin",
              style: TextStyle(
                  fontFamily: 'palatino',
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            backgroundColor: Color(0xFF947BF5),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: group(),
        ),
      );
    });
  }
}

class group extends StatefulWidget {
  @override
  State<group> createState() => _groupState();
}

class _groupState extends State<group> {
  @override
  void initState() {
    super.initState();
    getdetail();
    writeFile();
    // getDetails();
  }

  File? _image;
  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 100,
    );
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      Get.back();
      this._image = imageTemporary;
      imagecontroller.text = _image!.path;
      print(_image!.path);
    });
  }

  DateTime? currentBackPressTime;
  Future<bool> popFunction() {
    DateTime now = DateTime.now();
    if ((currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 5))) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<String?> getString(String type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(type);
  }

  // getDetails() async {
  //   // nameStr = await getString('name');
  //   // groupStr = await getString('group_id');
  //   // memidStr = await getString('member_id');
  //   setState(() {});
  // } // String? nameStr = '';
  // String? groupStr = '';
  // String? memidStr = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: popFunction,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 18),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Material(
                    elevation: 12,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 24, right: 24, top: 12, bottom: 12),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(

                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      children: [
                                        Text(
                                          'Name: ',
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'palatino',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          // nameController.text.toString(),
                                          //nameStr!,
                                          detailList.toString(),
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'palatino',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Group Id : ',
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'palatino',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          grpList.toString(),
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'palatino',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Member Id : ',
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'palatino',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          // memberid.toString(),
                                          memList.toString(),
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'palatino',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  height: 80,
                                  width: 80,
                                  child: ClipOval(

                                    child: Image.network(profile,fit: BoxFit.fill,),

                                  ),
                                ),

                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              _image != null
                                  ? CircleAvatar(
                                      radius: 50.0,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(
                                        'assets/man (1).png',
                                      ),
                                    )
                                  : ClipOval(
                                      child: InkWell(
                                      onTap: (() {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                  child: PhotoView(
                                                imageProvider:
                                                    NetworkImage(profilepic!),
                                              ));
                                            });
                                      }),
                                      child: profilepic != null
                                          ? Image.network(profilepic!,
                                              height: 110,
                                              width: 110,
                                              fit: BoxFit.cover)
                                          : Container(),
                                    )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 52),
                GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: (2 / 2.2),
                    ),
                    itemCount: 6,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          if (index == 0) {
                            Get.to(() => profileeditpage());
                          } else if (index == 1) {
                            Get.to(() => payment());
                          } else if (index == 2) {
                            Get.to(() => PayHistory());
                          } else if (index == 3) {
                            Get.to(() => Refund());
                          } else if (index == 4) {
                            Get.to(() => pay_screen());
                          } else if (index == 5) {
                            Get.to(() => message());
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Image.asset(gridData[index]['img']!,
                                  height: 60.sp,
                                  width: 60.sp,
                                  fit: BoxFit.contain),
                              Spacer(),
                              Text(
                                gridData[index]['text']!,
                                style: TextStyle(
                                    fontSize: 13, fontFamily: "palatino"),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      );
                    }),
                SizedBox(height: 65),
              ],
            ),
          ),
        ),
      ),
    );
  }

  writeFile() async {
    // storage permission ask
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  var memberdetails;
  var profilepic;

  // Future showprofileapi() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? updatedetail = pref.getString('memberdetail').toString();
  //   if (updatedetail == "null") {
  //     updatedetail = pref.getString('Profile').toString();
  //   }
  //   if (updatedetail != "null") {
  //     profilepic = pref.getString('photo');
  //     var kv = updatedetail
  //         .substring(0, updatedetail.length - 1)
  //         .substring(1)
  //         .split(",");
  //     final Map<String, String> pairs = {};

  //     for (int i = 0; i < kv.length; i++) {
  //       var thisKV = kv[i].split(":");
  //       pairs[thisKV[0]] = thisKV[1].trim();
  //     }

  //     var encoded = json.encode(pairs);
  //     setState(() {
  //       memberdetails = jsonDecode(encoded);
  //     });

  //     print("${memberdetails['name']}");
  //   }
  // }

  Future<void> getdetail() async {
    var url = "http://bhramayogi.teckzy.co.in/User_api/home_page";

    var pref = await SharedPreferences.getInstance();
    var memberid = pref.getString('member_id');
    print('this is member'+ memberid!);

    var finalurl = Uri.parse(url);
    var res = await http.post(finalurl, headers: <String, String>{
      'X-API-KEY': 'yogi@123',
    }, body: {
      'reg_id': memberid,
    });

    var decodeValue = json.decode(res.body);
    setState(() {
      detailList = decodeValue['data']['name'];
      memList = decodeValue['data']['member_id'];
      grpList = decodeValue['data']['member_group_id'];
      profile=decodeValue['data']['photo'];


    });
    pref.setString('member_id1', memList);
  }

  var gridData = [
    {'img': 'assets/user_(1).png', 'text': 'Profile'},
    {'img': 'assets/payment.png', 'text': 'Payment'},
    {'img': 'assets/debit-card.png', 'text': 'Payment History'},
    {'img': 'assets/cashback.png', 'text': 'Refund'},
    {'img': 'assets/wallet_(2).png', 'text': 'Upload Payment'},
    {'img': 'assets/chat.png', 'text': 'Message'},
  ];

  Future<void> getconvo(grpId) async {
    var url = "http://bhramayogi.teckzy.co.in/User_api/group_msg";

    var pref = await SharedPreferences.getInstance();
    var name = pref.getString('name');
    var memberid = pref.getString('member_id');
    var grpid = pref.getString('group_id');
    var finalurl = Uri.parse(url);
    var res = await http.post(finalurl, headers: <String, String>{
      'X-API-KEY': 'yogi@123',
    }, body: {
      'group_id': grpId.toString(),
    });

    var decodeValue = json.decode(res.body);
    setState(() {
      convoList = decodeValue['datas']['group_list'];
    });
  }
}
