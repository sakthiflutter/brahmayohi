import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Loginpage.dart';

TextEditingController useridcontroller = TextEditingController();
TextEditingController imagecontroller = TextEditingController();
var dateFormat = DateFormat('dd-MM-yyyy');
final TextEditingController DateController = TextEditingController();
var datefoemate=DateTime.now().toString();


bool box = false;
void transactionapi(member_id, pay_slip) async {
  var url = Uri.parse('$baseurl/transaction_history');
  var request = http.MultipartRequest('POST', url);
  request.headers.addAll(
    {
      "Content-type": "application/x-www-form-urlencoded",
      'x-api-key': 'yogi@123'
    },
  );
  request.fields['updated_dt']=datefoemate;

  request.fields['member_id'] = useridcontroller.text.toString();
  print(request.fields);
  var firstimage =
      await http.MultipartFile.fromPath('pay_slip', imagecontroller.text);
  request.files.add(firstimage);
  var response = await request.send();
  final respStr = await response.stream.bytesToString();
  var data = json.decode(respStr);
  print('hi sakthi'+data.toString());
  if (data['status'] == true) {
    print('hi sakthi1'+data.toString());
    Fluttertoast.showToast(msg: data['msg']);
  } else {
    print('hi sakthi2'+data.toString());
    Fluttertoast.showToast(msg: data['msg']);
  }
  useridcontroller.clear();
  imagecontroller.clear();

}

class pay_screen extends StatelessWidget {
  const pay_screen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF947BF5),
        title: Text(
          'Payment Report',
          style: TextStyle(fontSize: 22.0, fontFamily: "palatino"),
          textAlign: TextAlign.center,
        ),
      ),
      body: _pay_screen(),
    );
  }
}

class _pay_screen extends StatefulWidget {
  const _pay_screen({Key? key}) : super(key: key);

  @override
  State<_pay_screen> createState() => __pay_screenState();
}

class __pay_screenState extends State<_pay_screen> {

  var memberid;

  File? _image;
  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 100,
    );
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this._image = imageTemporary;
      imagecontroller.text = _image!.path;
      print(_image!.path);
    });
  }
  @override
  void initState() {
    DateController.text=dateFormat.format(DateTime.now());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 24),
        padding: EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: useridcontroller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8),
                  labelText: 'Member ID',
                  labelStyle: const TextStyle(
                      fontSize: 16, fontFamily: "palatino", color: Colors.grey),
                  suffixIcon: Checkbox(
                      value: box,
                      onChanged: (value) async {
                        if (value!) {
                          var pref = await SharedPreferences.getInstance();
                          memberid = pref.getString('member_id1');
                          useridcontroller.text = memberid.toString();
                        } else {
                          useridcontroller.clear();
                        }
                        setState(() {
                          box = value;
                        });
                      }),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
                child: TextField(
                    controller: imagecontroller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Attach Payment screenshot',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      suffixIcon: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 120,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(15, 8, 15, 8),
                          child: ElevatedButton(
                            onPressed: () => getImage(ImageSource.gallery),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF947BF5) // foreground
                                ),
                            // color: Color(0xFF947BF5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 15),
                                Text('Gallery',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ))),
            SizedBox(height: 16),

            TextField(
              enabled: true,
              controller: DateController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 8),
                labelText: 'Member ID',

                  suffixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: IconButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(

                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2400),
                          );
                          DatePicker.showDatePicker(

                            context,
                            initialDateTime: DateTime.now(),
                            minDateTime: DateTime(1900),
                            maxDateTime: DateTime(2400),
                            onMonthChangeStartWithFirstDate: true,
                            onConfirm: (dateTime, List<int> index) {
                              DateTime selectdate = dateTime;
                              final selIOS = DateFormat('dd-MMM-yyyy - HH:mm').format(selectdate);
                              print(selIOS);
                            },
                          );
                          if (newDate == null) return;
                          setState(() {

                              DateController.text =
                                  DateFormat('dd-MM-yyyy')
                                      .format(newDate)
                                      .toString();
                              datefoemate=newDate.toString();
                              print(newDate);


                          });
                        },
                        icon: Icon(Icons.calendar_month)),
                  ),
                  enabled: false,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),),
              // ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  if (useridcontroller.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'please give member id');
                  } else if (imagecontroller.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please attach screenshot');
                  } else {
                    transactionapi(useridcontroller, imagecontroller);
                    setState(() {
                      box=false;
                    });

                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF947BF5) // foreground
                ),
                // color: Color(0xFF947BF5),
                child: Text('save',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'palatino')),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
