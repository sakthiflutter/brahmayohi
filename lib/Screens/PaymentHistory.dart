import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:brahmayogi/Screens/Loginpage.dart';
import 'package:brahmayogi/Screens/Message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

// void initilizeDownloader() async {
//   FlutterDownloader.initialize();
//   WidgetsFlutterBinding.ensureInitialized();
// }

late String _localPath;
late bool _permissionReady;
late TargetPlatform? platform;

Future<void> _prepareSaveDir() async {
  _localPath = (await _findLocalPath())!;

  print(_localPath);
  final savedDir = Directory(_localPath);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create();
  }
}

Future<String?> _findLocalPath() async {
  if (platform == TargetPlatform.android) {
    //return "/sdcard/download/";
    return "/storage/emulated/0/Download";
  } else {
    var directory = await getApplicationDocumentsDirectory();
    return directory.path + Platform.pathSeparator + 'Download';
  }
}

Future<bool> _checkPermission() async {
  if (platform == TargetPlatform.android) {
    final status = await Permission.manageExternalStorage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.manageExternalStorage.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }
  } else {
    return true;
  }
  return true;
}

bool loading = false;
var payment_history;
List<String> _locations = [
  'current_month',
  'last_month',
  'last_3_months',
  'last_6_months',
  'last_12_months',
  'last_2_years',
  'last_4_years',
  'total_years'
];
String? _selectedLocation;


class PayHistory extends StatelessWidget {
  const PayHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCE8EE),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Payment History',
          style: TextStyle(fontFamily: 'palatino', fontSize: 20),
        ),
        backgroundColor: Color(0xFF947BF5),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const Home()),
      //     );
      //   },
      //   label: Text(
      //     "Click to Download",
      //     style: TextStyle(
      //         fontFamily: 'palatino',
      //         fontWeight: FontWeight.bold,
      //         fontSize: 15),
      //   ),
      //   backgroundColor: Color(0xFF947BF5),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: PayHistorys(),
    );
  }
}

class PayHistorys extends StatefulWidget {
  const PayHistorys({Key? key}) : super(key: key);

  @override
  State<PayHistorys> createState() => _PayHistorysState();
}

class _PayHistorysState extends State<PayHistorys> {

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? SingleChildScrollView(
            child: Container(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ListView.builder(
                      itemCount: 1,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Column(children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Total Subscription amount Paid: ${payment_history[0]['subscriptionAmount']??'0'}',
                                        style: TextStyle(
                                            fontFamily: 'palatino',
                                            color: Colors.black,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(
                                        'Total Donation amount Paid: ${payment_history[0]['trustAmount']??'0'}',
                                        style: TextStyle(
                                            fontFamily: 'palatino',
                                            color: Colors.black,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(
                                        'Grand Total: ${payment_history[0]['GrandTotal']??'0'}',
                                        style: TextStyle(
                                            fontFamily: 'palatino',
                                            color: Colors.black,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Row(
                //       children: [
                //         Container(
                //           child: Text(
                //             'From: ',
                //             style: TextStyle(fontSize: 12, fontFamily: 'palatino'),
                //           ),
                //         ),
                //         InkWell(
                //           onTap: () async {
                //             DateTime? newDate = await showDatePicker(
                //               context: context,
                //               initialDate: _FromdateTime,
                //               firstDate: DateTime(1900),
                //               lastDate: DateTime(2100),
                //             );
                //             if (newDate == null) return;
                //             setState(() {
                //               _FromdateTime = newDate;
                //               Fromdate =
                //                   '${_FromdateTime.day}-${_FromdateTime.month}-${_FromdateTime.year}';
                //               print(Fromdate.toString());
                //             });
                //           },
                //           child: Container(
                //             width: 135,
                //             height: 40,
                //             child: TextField(
                //               controller: Fromcontroller,
                //               keyboardType: TextInputType.number,
                //               decoration: InputDecoration(
                //                 hintText:
                //                     "${_FromdateTime.day}-${_FromdateTime.month}-${_FromdateTime.year}",
                //                 hintStyle: const TextStyle(
                //                     fontSize: 12,
                //                     height: 0.9,
                //                     fontFamily: 'palatino',
                //                     color: Colors.black),
                //                 suffixIcon: Align(
                //                   widthFactor: 1.0,
                //                   heightFactor: 1.0,
                //                   child: IconButton(
                //                     onPressed: () async {
                //                       DateTime? newDate = await showDatePicker(
                //                         context: context,
                //                         initialDate: _FromdateTime,
                //                         firstDate: DateTime(1800),
                //                         lastDate: DateTime(3000),
                //                       );
                //                       if (newDate == null) return;
                //                       setState(
                //                         () => _FromdateTime = newDate,
                //                       );
                //                     },
                //                     icon: const Icon(Icons.calendar_month),
                //                     iconSize: 20,
                //                     color: Colors.blue,
                //                   ),
                //                 ),
                //                 focusedBorder: OutlineInputBorder(
                //                   borderSide: const BorderSide(
                //                     color: Colors.black12,
                //                   ),
                //                 ),
                //                 enabledBorder: const OutlineInputBorder(
                //                   borderSide: BorderSide(
                //                     color: Colors.black12,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     SizedBox(width: 12),
                //     Row(
                //       children: [
                //         Container(
                //           child: Text(
                //             'To: ',
                //             style: TextStyle(fontSize: 12, fontFamily: 'palatino'),
                //           ),
                //         ),
                //         InkWell(
                //           onTap: () async {
                //             DateTime? newDate = await showDatePicker(
                //               context: context,
                //               initialDate: _TodateTime,
                //               firstDate: DateTime(1900),
                //               lastDate: DateTime(2100),
                //             );
                //             if (newDate == null) return;
                //             setState(() {
                //               _TodateTime = newDate;
                //               Todate =
                //                   '${_TodateTime.day}-${_TodateTime.month}-${_TodateTime.year}';
                //               print(Todate.toString());
                //             });
                //           },
                //           child: Container(
                //             width: 135,
                //             height: 40,
                //             child: TextField(
                //               controller: Tocontroller,
                //               keyboardType: TextInputType.number,
                //               decoration: InputDecoration(
                //                 suffixIcon: Align(
                //                   widthFactor: 1.0,
                //                   heightFactor: 1.0,
                //                   child: IconButton(
                //                     onPressed: () async {
                //                       DateTime? newDate = await showDatePicker(
                //                         context: context,
                //                         initialDate: _TodateTime,
                //                         firstDate: DateTime(1800),
                //                         lastDate: DateTime(3000),
                //                       );
                //                       if (newDate == null) return;
                //                       setState(
                //                         () => _TodateTime = newDate,
                //                       );
                //                       fromdate = DateFormat('dd-MM-yyyy')
                //                           .format(_FromdateTime);
                //                       todate = DateFormat('dd-MM-yyyy')
                //                           .format(_TodateTime);
                //                       setState(() {});
                //                     },
                //                     icon: const Icon(Icons.calendar_month),
                //                     iconSize: 20,
                //                     color: Colors.blue,
                //                   ),
                //                 ),
                //                 hintText:
                //                     "${_TodateTime.day}-${_TodateTime.month}-${_TodateTime.year}",
                //                 hintStyle: const TextStyle(
                //                     fontFamily: 'palatino',
                //                     fontSize: 12,
                //                     height: 0.9,
                //                     color: Colors.black),
                //                 focusedBorder: OutlineInputBorder(
                //                   borderSide: const BorderSide(color: Colors.black12),
                //                 ),
                //                 enabledBorder: const OutlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.black12),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     )
                //   ],
                // ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Color(0xFF947BF5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Account Statement',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'palatino',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 180,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  filled: true,
                                  hintText: 'Statement'),
                              value: _selectedLocation,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedLocation = newValue.toString();
                                });
                                // paymenthistorydownload();
                              },
                              items: _locations.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: ElevatedButton(
                              onPressed: () async {
                                print('data');

                              await  paymenthistorydownload();
                                // if (pay_history_download.toString() != '[]') {

                                // }

                                _permissionReady = await _checkPermission();
                                if (_permissionReady) {
                                  await _prepareSaveDir();
                                  print("Downloading");
                                  try {
                                    Random random = new Random();
                                    int randomNumber = random.nextInt(400);
                                    await Dio().download(
                                        pay_history_download.toString(),
                                        _localPath + "/" + "pay history${randomNumber!.toString()}.pdf"); 
                                        Noti.showBigTextNotification(title: "Sucessfully Dowloaded", body: "pay history${randomNumber!.toString()}.pdf", fln: flutterLocalNotificationsPlugin);
                                    print("Download Completed.");
                                    Fluttertoast.showToast(
                                        msg: 'File Downloaded');
                                  } catch (e) {
                                    print(
                                        "Download Failed.\n\n" + e.toString());
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color(0xFF947BF5) // foreground
                                  ),
                              // color: Color(0xFF947BF5),
                              child: Text('Click to Download',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'palatino')),
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Text('Download percentage'),
                      //     Text('$progress'),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ],
            )),
          )
        : Center(child: CircularProgressIndicator());
  }

  paymenthistory() async {
    var url = Uri.parse('$baseurl/payment_history');
    var pref = await SharedPreferences.getInstance();
    var member_id = pref.getString('member_id');
    var res = await http.post(url, headers: <String, String>{
      'X-API-KEY': 'yogi@123',
    }, body: {
      'member_id': member_id.toString(),
    });
    print(json.decode(res.body));
    var decodeValue = json.decode(res.body);
    setState(() {
      payment_history = decodeValue;
      loading = true;
    });
  }
  Future<void> _showNotification() async {
    int a=1;

    const NotificationDetails notificationDetails =
    NotificationDetails();
    await flutterLocalNotificationsPlugin.show(
        a++, 'plain title', 'plain body', notificationDetails,
       );
  }

  var pay_history_download;
  paymenthistorydownload() async {
    var url = Uri.parse('$baseurl/payment_history_download');
    var pref = await SharedPreferences.getInstance();
    var member_id = pref.getString('member_id');
    var res = await http.post(url, headers: <String, String>{
      'X-API-KEY': 'yogi@123',
    }, body: {
      'member_id': member_id.toString(),
      'date': _selectedLocation ?? 'current_month',
    });
  var decodeValue = json.decode(res.body);
    print(9786);
  print(decodeValue);
    setState(() {

      pay_history_download = decodeValue['url'].toString();
      print('link' + pay_history_download.toString());
    });
  }

  // int progress = 0;
  // ReceivePort receiveport = ReceivePort();

  @override
  void initState() {
    Noti.initialize(flutterLocalNotificationsPlugin);
    // initilizeDownloader();
    // IsolateNameServer.registerPortWithName(
    //     receiveport.sendPort, "downloadingfile");
    // receiveport.listen((message) {
    //   setState(() {
    //     progress = message;
    //   });
    // });
    // fromdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    // todate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    paymenthistory();
    // FlutterDownloader.registerCallback(downloadCallback);

    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
    super.initState();
  }

  // static downloadCallback(id, status, progress) {
  //   SendPort? sendport = IsolateNameServer.lookupPortByName('downloadingfile');
  //   sendport!.send(progress);
  // }

  // void downloadFile() async {
  //   final status = await Permission.storage.request();

  //   if (status.isGranted) {
  //     final baseStorage = await getExternalStorageDirectory();
  //     final id = await FlutterDownloader.enqueue(
  //         url: payment_history.toString(),
  //         savedDir: baseStorage!.path,
  //         fileName: 'Payment History');
  //     print('ress' + id.toString());
  //   } else {
  //     print('no permission');
  //   }
  // }
}
class Noti{
  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationsSettings = new InitializationSettings(android: androidInitialize,
        iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings );
  }

  static Future showBigTextNotification({var id =0,required String title, required String body,
    var payload, required FlutterLocalNotificationsPlugin fln
  } ) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Succesfully Dowloaded', 'pay history.pdf', notificationDetails,
        payload: 'item x'


);




}

}