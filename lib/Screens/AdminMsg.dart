import 'dart:convert';
import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

var admin_msgs = [];

class admin extends StatefulWidget {
  const admin({Key? key}) : super(key: key);

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  static const styleSomebody = BubbleStyle(
    nip: BubbleNip.leftCenter,
    color: Colors.white,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topLeft,
  );

  static const styleMe = BubbleStyle(
    nip: BubbleNip.rightCenter,
    color: Color.fromARGB(255, 225, 255, 199),
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, left: 50),
    alignment: Alignment.topRight,
  );

  static var httpClient = new HttpClient();
  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getTemporaryDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  File? _imageID;
  FilePickerResult? attachment;
  File? attachFile;
  Future getIDImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this._imageID = imageTemporary;
      con.text = '.';
      attachFile = null;
      attachment = null;
      Get.back();
      admin_msg('.', 'image');
    });
  }

  @override
  void initState() {
    admin_msg('yogi@123', 'msg');
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    admin_msg('yogi@123', 'msg');
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  List<String> list = [];
  TextEditingController con = TextEditingController();
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFDCE8EE),
        appBar: AppBar(
          backgroundColor: Color(0xFF947BF5),
          leadingWidth: 70,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back, size: 28),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/Intersection 4.png'),
                  radius: 20,
                  backgroundColor: Colors.white,
                )
              ],
            ),
          ),
          title: Column(
            children: [
              Text(
                'Admin',
                style: TextStyle(fontFamily: 'palatino', fontSize: 22),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    reverse: true,
                    itemCount: admin_msgs.length,
                    itemBuilder: (context, index) {
                      print(admin_msgs);
                      return Column(
                        children: [
                          admin_msgs[index]['message_type'] == 'msg'
                              ? Bubble(
                                  style: admin_msgs[index]['sender'] != 'user'
                                      ? styleSomebody
                                      : styleMe,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      SelectableText(
                                        admin_msgs[index]['message']!,
                                        style: TextStyle(
                                            fontFamily: 'palatino', fontSize: 12),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SelectableText(
                                            DateFormat.yMd().add_jms().format(DateTime.parse('${admin_msgs[index]['date']!}')),
                                            style:
                                            TextStyle(fontFamily: 'palatino', fontSize: 10),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : admin_msgs[index]['message_type'] == 'image'
                                  ? Bubble(
                                      style:
                                          admin_msgs[index]['sender'] != 'user'
                                              ? styleSomebody
                                              : styleMe,
                                      child: Column(

                                        children: [
                                          InkWell(
                                            onTap: (() {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                        child: PhotoView(
                                                          imageProvider: NetworkImage(

                                                              admin_msgs[index]
                                                              ['message']!),
                                                        ));
                                                  });
                                            }),
                                            child: Image.network(

                                              admin_msgs[index]['message']!,
                                              fit: BoxFit.cover,
                                              height: 180,
                                              width: 160,
                                            ),
                                          ),Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              SelectableText(
                                                DateFormat.yMd().add_jms().format(DateTime.parse('${admin_msgs[index]['date']!}')),
                                                style:
                                                TextStyle(fontFamily: 'palatino', fontSize: 10),
                                              ),
                                            ],
                                          )
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      ),
                                    )
                                  : admin_msgs[index]['message_type'] == 'file'||admin_msgs[index]['message_type'] == 'video'||admin_msgs[index]['message_type'] == 'audio'
                                      ? Bubble(
                                          style: admin_msgs[index]['sender'] !=
                                                  'user'
                                              ? styleSomebody
                                              : styleMe,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  File download = await _downloadFile(

                                                      admin_msgs[index]
                                                      ['message']
                                                          .toString(),
                                                      admin_msgs[index]['message']
                                                          .toString()
                                                          .split('/')
                                                          .last);
                                                  print(download);
                                                  OpenFilex.open(download.path);
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                        Icons.attach_file_outlined),
                                                    Text(admin_msgs[index]
                                                    ['message']
                                                        .toString()
                                                        .split('/')
                                                        .last),
                                                  ],
                                                ),
                                              ),Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  SelectableText(
                                                    DateFormat.yMd().add_jms().format(DateTime.parse('${admin_msgs[index]['date']!}')),
                                                    style:
                                                    TextStyle(fontFamily: 'palatino', fontSize: 10),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      : Bubble(
                                          style: admin_msgs[index]['sender'] !=
                                                  'user'
                                              ? styleSomebody
                                              : styleMe,
                                          child: SelectableText(admin_msgs[index]
                                                  ['message']
                                              .toString()),
                                        ),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     _imageID != null || attachFile != null
              //         ? Container(
              //             width: width / 3.5,
              //             height: height / 6,
              //             child: SizedBox(
              //               width: 20,
              //               height: 20,
              //               child: Bubble(
              //                 child: _imageID != null
              //                     ? Image.file(_imageID!,
              //                         width: 20, height: 60, fit: BoxFit.fill)
              //                     : Image.asset("assets/file.png",
              //                         width: 20, height: 60, fit: BoxFit.fill),
              //               ),
              //             ))
              //         : Container(),
              //   ],
              // ),
              // SizedBox(height: 2),
              MessageBar(
                onSend: (str) {
                  admin_msg(str, 'msg');
                },
                actions: [
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: InkWell(
                      child: Icon(
                        Icons.attach_file_rounded,
                        color: Colors.grey,
                        size: 24,
                      ),
                      onTap: () {
                        Get.bottomSheet(
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            padding: EdgeInsets.only(
                              top: 6,
                              bottom: 6,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    attachment =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: [
                                        'pdf',
                                        'doc',
                                        'mp4',
                                        'mp3'
                                      ],
                                    );
                                    if (attachment != null) {
                                      attachFile = File(
                                          '${attachment!.files.single.path}');
                                      con.text = '.';
                                      _imageID = null;
                                      setState(() {});
                                      Get.back();
                                      admin_msg('.', 'file');
                                      print('res ${attachFile!.path}');
                                    } else {
                                      print("No file selected");
                                    }
                                  },
                                  // color: Color(0xFF947BF5),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color(0xFF947BF5) // foreground
                                      ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.attach_file_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 15),
                                      Text('Files',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: () =>
                                      getIDImage(ImageSource.gallery),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color(0xFF947BF5) // foreground
                                      ),
                                  // color: Color(0xFF947BF5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.image_outlined,
                                          color: Colors.white),
                                      SizedBox(width: 15),
                                      Text('Gallery',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: () =>
                                      getIDImage(ImageSource.camera),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color(0xFF947BF5) // foreground
                                      ),
                                  // color: Color(0xFF947BF5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.camera_alt_outlined,
                                          color: Colors.white),
                                      SizedBox(width: 15),
                                      Text('Camera',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              // ChatComposer(
              //   controller: con,
              //   onReceiveText: (str) {
              //     admin_msg(str, 'msg');
              //   },
              //   // onRecordStart: (){
              //   // if(con.text.isEmpty){
              //   //   Fluttertoast.showToast(msg: 'Please give some message');
              //   // }
              //   // },
              //   onRecordEnd: (path) {
              //     // setState(() {
              //     //   admin_msg(path, 'audio');
              //     // });

              //   },

              //   textPadding: EdgeInsets.zero,
              //   leading: CupertinoButton(
              //     padding: EdgeInsets.zero,
              //     child: const Icon(
              //       Icons.attach_file_rounded,
              //       size: 25,
              //       color: Colors.grey,
              //     ),
              //     onPressed: () {
              //       Get.bottomSheet(
              //         Container(
              //           decoration: BoxDecoration(
              //               color: Colors.white54,
              //               borderRadius: BorderRadius.only(
              //                   topLeft: Radius.circular(20),
              //                   topRight: Radius.circular(20),
              //                   bottomLeft: Radius.circular(20),
              //                   bottomRight: Radius.circular(20))),
              //           padding: EdgeInsets.only(
              //             top: 6,
              //             bottom: 6,
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               RaisedButton(
              //                 onPressed: () async {
              //                   attachment = await FilePicker.platform.pickFiles(
              //                     type: FileType.custom,
              //                     allowedExtensions: ['pdf', 'doc', 'mp4', 'mp3'],
              //                   );
              //                   if (attachment != null) {
              //                     attachFile =
              //                         File('${attachment!.files.single.path}');
              //                     con.text = '.';
              //                     _imageID = null;
              //                     setState(() {});
              //                     Get.back();
              //                     print('res ${attachFile!.path}');
              //                   } else {
              //                     print("No file selected");
              //                   }
              //                 },
              //                 color: Color(0xFF947BF5),
              //                 child: Row(
              //                   children: [
              //                     Icon(
              //                       Icons.attach_file_outlined,
              //                       color: Colors.white,
              //                     ),
              //                     SizedBox(width: 15),
              //                     Text('Files',
              //                         style: TextStyle(color: Colors.white)),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 12),
              //               RaisedButton(
              //                 onPressed: () => getIDImage(ImageSource.gallery),
              //                 color: Color(0xFF947BF5),
              //                 child: Row(
              //                   children: [
              //                     Icon(Icons.image_outlined, color: Colors.white),
              //                     SizedBox(width: 15),
              //                     Text('Gallery',
              //                         style: TextStyle(color: Colors.white)),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 12),
              //               RaisedButton(
              //                 onPressed: () => getIDImage(ImageSource.camera),
              //                 color: Color(0xFF947BF5),
              //                 child: Row(
              //                   children: [
              //                     Icon(Icons.camera_alt_outlined,
              //                         color: Colors.white),
              //                     SizedBox(width: 15),
              //                     Text('Camera',
              //                         style: TextStyle(color: Colors.white)),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> admin_msg(message, types) async {
    var url = "http://bhramayogi.teckzy.co.in/User_api/admin_msg";
    var pref = await SharedPreferences.getInstance();
    var memberid = pref.getString('member_id');
    print(memberid.toString());
    var finalurl = Uri.parse(url);

    var request = http.MultipartRequest('POST', finalurl);
    if (_imageID != null) {
      var firstimage = await http.MultipartFile.fromPath('msg', _imageID!.path);
      request.files.add(firstimage);
      types = "image";
    }
    if (types == 'audio') {
      print(message);
      var firstfile = await http.MultipartFile.fromPath('msg', message);
      request.files.add(firstfile);
    }
    if (attachFile != null) {
      var firstfile =
          await http.MultipartFile.fromPath('msg', attachFile!.path);
      request.files.add(firstfile);
      if (attachFile!.path.toString().split('.').last == 'mp3') {
        types = "audio";
      } else {
        types = "file";
      }
    }

    request.headers.addAll(
      {
        "Content-type": "application/x-www-form-urlencoded",
        'X-API-KEY': 'yogi@123',
      },
    );
    request.fields['member_id'] = memberid.toString();
    print(request.fields);
    print(memberid.toString());
    if (_imageID == null && attachFile == null) {
      request.fields['msg'] = message == '.' ? '' : message;
    }
    request.fields['type'] = types;

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var decodeValue = json.decode(respStr);

    if (decodeValue['status']) {

      setState(() {
        admin_msgs = decodeValue['admin_msg'];

        con.clear();
        _imageID = null;
        attachment = null;
        attachFile = null;
      });
    }
  }
}
