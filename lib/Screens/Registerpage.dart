import 'dart:convert';
import 'dart:io';
import 'package:brahmayogi/Screens/EditProfile.dart';
import 'package:brahmayogi/Screens/Family%20Details.dart';
import 'package:brahmayogi/Screens/Loginpage.dart';
import 'package:brahmayogi/auth/EditProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'Homepage.dart';
import 'Subscription.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;

var baseurl = 'http://bhramayogi.teckzy.co.in/User_api';
var otpvalue = '';
var resendval = true;
final TextEditingController otp = TextEditingController();
final TextEditingController Registerotp = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController EmailController = TextEditingController();
TextEditingController MObileNOController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController ConfirmPasswordController = TextEditingController();
TextEditingController SelectIDController = TextEditingController();
TextEditingController UploadIDController = TextEditingController();
TextEditingController DOBController = TextEditingController();
TextEditingController AgeController = TextEditingController();
TextEditingController GenderController = TextEditingController();
TextEditingController EducationController = TextEditingController();
TextEditingController CurrentController = TextEditingController();
TextEditingController PermanentController = TextEditingController();
TextEditingController ProfessionalDetailsController = TextEditingController();
TextEditingController ExperienceController = TextEditingController();
TextEditingController IncomeController = TextEditingController();
TextEditingController FamilyNameController = TextEditingController();
TextEditingController AlterMObileNOController = TextEditingController();
TextEditingController PincodeController = TextEditingController();
TextEditingController CountryController = TextEditingController();
TextEditingController PerPincodeController = TextEditingController();
TextEditingController PerCountryController = TextEditingController();
TextEditingController SkillController = TextEditingController();
TextEditingController ProfessionalController = TextEditingController();
TextEditingController JobController = TextEditingController();

List<String> dropdownValuesGender = ['male', 'female'];
List<String> dropdownValuesMarital = ['married', 'unmarried'];
var dropdownValuesIDproff = [];
var dropdownValuesDistrict = [];
var dropdownValuesState = [];
var dropdownValusProfessional = [];
String? professionalValue;
String? idprofValue;
String? districtValue;
String? stateValue;
String? dropdownValueGender;
String? dropdownValueMarital;
String? perdistrictValue;
String? perstateValue;

void Registerapi() async {
  final uri = Uri.parse(baseurl + '/register');
  var request = http.MultipartRequest('POST', uri);

  request.headers.addAll(
    {
      "Content-type": "application/x-www-form-urlencoded",
      'x-api-key': 'yogi@123'
    },
  );
  print('mobile Num' + MObileNOController.text.toString());
  print('Alt Num' + AlterMObileNOController.text.toString());
  print('maried_status' + dropdownValueMarital.toString());
  print('dob' + DOBController.text.toString());
  print('age' + AgeController.text.toString());
  print('gender' + dropdownValueGender.toString());
  print('name' + nameController.text.toString());
  print('email' + EmailController.text.toString());
  print('family_details' + familyList.toString());
  print('password' + passwordController.text.toString());
  print('qualification' + EducationController.text.toString());
  print('professional' + professionalValue.toString());
  print('professional_deatils' + ProfessionalDetailsController.text.toString());
  print('cur_address' + CurrentController.text.toString());
  print('cur_pincode' + PincodeController.text.toString());
  print('cur_district' + districtValue.toString());
  print('cur_state' + stateValue.toString());
  print('per_country' + CountryController.text.toString());
  print('salary' + IncomeController.text.toString());
  print('job_experience' + ExperienceController.text.toString());
  print('skills' + SkillController.text.toString());
  print('current_situation' + JobController.text.toString());

  // request.fields['whatsapp_no'] = MObileNOController.text.toString();
  // request.fields['alter_mobileno'] = AlterMObileNOController.text.toString();
  // request.fields['maried_status'] = dropdownValueMarital.toString();
  // request.fields['dob'] = DOBController.text;
  // request.fields['age'] = AgeController.text.toString();
  // request.fields['gender'] = dropdownValueGender.toString();
  // request.fields['name'] = nameController.text.toString();
  // request.fields['email'] = EmailController.text.toString();
  // request.fields['family_details'] = '6members';
  // request.fields['password'] = passwordController.text.toString();
  // request.fields['qualification'] = EducationController.text.toString();
  // request.fields['professional'] = professionalValue.toString();
  // request.fields['professional_deatils'] =
  //     ProfessionalDetailsController.text.toString();
  // request.fields['cur_address'] = CurrentController.text.toString();
  // request.fields['cur_pincode'] = PincodeController.text.toString();
  // request.fields['cur_district'] = districtValue.toString();
  // request.fields['cur_state'] = stateValue.toString();
  // request.fields['cur_country'] = CountryController.text.toString();
  // request.fields['per_address'] = PermanentController.text.toString();
  // request.fields['per_pincode'] = PerPincodeController.text.toString();
  // request.fields['per_district'] = perdistrictValue.toString();
  // request.fields['per_state'] = perstateValue.toString();
  // request.fields['per_country'] = PerCountryController.text.toString();
  // request.fields['salary'] = IncomeController.text.toString();
  // request.fields['job_experience'] = ExperienceController.text.toString();
  // request.fields['skills'] = SkillController.text.toString();
  // request.fields['current_situation'] = JobController.text.toString();

  request.fields['whatsapp_no'] = MObileNOController.text.toString();
  request.fields['alter_mobileno'] = AlterMObileNOController.text.toString();
  request.fields['maried_status'] = dropdownValueMarital.toString();
  request.fields['dob'] = DOBController.text;
  request.fields['age'] = AgeController.text.toString();
  request.fields['gender'] = dropdownValueGender.toString();
  request.fields['name'] = nameController.text.toString();
  request.fields['email'] = EmailController.text.toString();
  request.fields['family_details'] = json.encode(familyList);
  print('family list' + json.encode(familyList));
  request.fields['password'] = passwordController.text.toString();
  request.fields['qualification'] = EducationController.text.toString();
  request.fields['professional'] = professionalValue.toString();
  request.fields['professional_deatils'] =
      ProfessionalDetailsController.text.toString();
  request.fields['cur_address'] = CurrentController.text.toString();
  request.fields['cur_pincode'] = PincodeController.text.toString();
  request.fields['cur_district'] = districtValue.toString();
  request.fields['cur_state'] = stateValue.toString();
  request.fields['cur_country'] = CountryController.text.toString();
  request.fields['per_address'] = PermanentController.text.toString();
  request.fields['per_pincode'] = PerPincodeController.text.toString();
  request.fields['per_district'] = perdistrictValue.toString();
  request.fields['per_state'] = perstateValue.toString();
  request.fields['per_country'] = PerCountryController.text.toString();
  request.fields['salary'] = IncomeController.text.toString();
  request.fields['job_experience'] = ExperienceController.text.toString();
  request.fields['skills'] = SkillController.text.toString();
  request.fields['current_situation'] = JobController.text.toString();
  var firstimage =
      await http.MultipartFile.fromPath('photo', SelectIDController.text);
  request.files.add(firstimage);
  var firstimage2 =
      await http.MultipartFile.fromPath('proof', UploadIDController.text);
  request.files.add(firstimage2);
  var response = await request.send();
  final respStr = await response.stream.bytesToString();
  var data = json.decode(respStr);
  print('register details' + data.toString());
  if (data['status']) {
    nameController.clear();
    DOBController.clear();

    AgeController.clear();
    GenderController.clear();
    UploadIDController.clear();
    EducationController.clear();
    EmailController.clear();
    MObileNOController.clear();
    AlterMObileNOController.clear();
    passwordController.clear();
    ConfirmPasswordController.clear();
    ProfessionalDetailsController.clear();
    SelectIDController.clear();
    CurrentController.clear();
    PincodeController.clear();
    PerCountryController.clear();
    IncomeController.clear();
    ExperienceController.clear();
    SkillController.clear();
    CurrentController.clear();
    dropdownValueMarital = null;
    dropdownValueGender = null;
    perdistrictValue = null;
    perstateValue = null;
    professionalValue = null;
    idprofValue = null;
    stateValue = null;
    districtValue = null;

    Get.offAll(() => Login());
    Fluttertoast.showToast(msg: data['msg']);
    /* var memberid = prefs.getString('member_id');

    String user = jsonEncode(data['user']);
    prefs.setString('Profile', user);
    Map userMap = jsonDecode(prefs.getString('Profile')!);
    ProfileModel user1 = ProfileModel.fromJson(userMap);
    print(user1); */
  } else {
    Fluttertoast.showToast(msg: data['msg']);
  }
  // print('response' + data.toString());
}

void getotp(mobile) async {
  var url = Uri.parse('$baseurl/generate_otp');
  final response = await http.post(url, headers: <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
    'x-api-key': 'yogi@123'
  }, body: {
    'mobile_no': mobile,
  });
  var data = json.decode(response.body);
  print(response.body.toString());
  if (data[0]['status'] == true) {
    Fluttertoast.showToast(msg: otpvalue = data[0]['otp_no']);
    Get.bottomSheet(
      Container(
        height: 360,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(25.0),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "OTP Verification",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "palatino",
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: Get.width * .8,
                        child: PinPut(
                            controller: otp,
                            onChanged: (o) {
                              if (o.length == 6) {
                                if (otpvalue == otp.text) {
                                  print('otp correct');
                                  Registerapi();
                                } else {
                                  print(finalList.toString());
                                  Fluttertoast.showToast(msg: 'Invalid Otp');
                                }
                                otp.clear();
                              }
                            },
                            keyboardType: TextInputType.number,
                            submittedFieldDecoration:
                                _pinPutDecoration.copyWith(
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                            followingFieldDecoration:
                                _pinPutDecoration.copyWith(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            selectedFieldDecoration: _pinPutDecoration,
                            fieldsCount: 6),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(25.0),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "We have sent an OTP to your",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "palatino",
                              color: Colors.grey[400]),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "mobile number",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "palatino",
                              color: Colors.grey[400]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          resendval ? 'Resend' : '',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "palatino",
                              color: Colors.black),
                        ),
                        onPressed: () {
                          Get.back();
                          getotp(mobile);
                        },
                      ),
                      Text(
                        "OTP  0:",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "palatino",
                            color: Colors.grey),
                      ),
                      Countdown(
                        seconds: 30,
                        build: (BuildContext context, double time) => Text(
                            time.toString().split('.')[0],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                        interval: Duration(milliseconds: 100),
                        onFinished: () {},
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 140, right: 140),
                    child: Column(children: [
                      OutlinedButton(
                          onPressed: () {
                            // if (otpvalue == otp.text) {
                            //   print('otp correct');
                            Registerapi();
                            // } else {
                            //   print('asaswsd' + finalList.toString());
                            //   Fluttertoast.showToast(msg: 'Invalid Otp');
                            // }
                            otp.clear();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF947BF5)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ))),
                          child: Text(
                            "Verify",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ))
                    ])),
              ],
            ),
          ),
        ),
      ),
      enableDrag: false,
    );
  } else {
    Fluttertoast.showToast(msg: data[0]['msg'].toString());
  }
  // print(response.body.toString());
}

class registerpage extends StatefulWidget {
  const registerpage({Key? key}) : super(key: key);

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  var size, height, width;

  File? _image;
  File? _imageID;
  bool box = false;

  DateTime date = DateTime(1900, 01, 01);
  File? imageTemporary;
  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    imageTemporary = File(image.path);
    setState(() {
      Get.back();
      this._image = imageTemporary;
      SelectIDController.text = image.path;
      print(_image!.path);
    });
  }

  Future getIDImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      Get.back();
      this._imageID = imageTemporary;
      UploadIDController.text = image.path;
      print(_imageID!.path);
    });
  }

  @override
  void initState() {
    getData();
    getData1();

    getData3();
    super.initState();
  }

  bool value = true;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ListView(children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 36),
              child: Column(children: [
                new Image.asset(
                    "assets/WhatsApp Image 2022-08-16 at 10.35.51 AM.jpg",
                    width: 180),
              ]),
            ),
            SizedBox(height: 26),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20, fontFamily: "palatino"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
                padding: EdgeInsets.all(0),
                child: TextField(
                    controller: nameController,
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    // ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Name',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // InkWell(
                //   onTap: () async {
                //     DateTime? newDate = await showDatePicker(
                //       context: context,
                //       initialDate: date,
                //       firstDate: DateTime(1900),
                //       lastDate: DateTime(2100),
                //     );
                //     if (newDate == null) return;
                //     setState(() {
                //       date = newDate;
                //       seletedDate = '${date.day}-${date.month}-${date.year}';
                //       print(seletedDate.toString());
                //     });
                //   },
                //   child: Container(
                //       width: 225,
                //       child: TextField(
                //           controller: DOBController,
                //           enabled: false,
                //           decoration: InputDecoration(
                //             contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                //             labelText: '${date.day}-${date.month}-${date.year}',
                //             labelStyle: TextStyle(
                //                 fontSize: 16,
                //                 fontFamily: "palatino",
                //                 color: Colors.black),
                //             suffixIcon: Align(
                //               widthFactor: 1.0,
                //               heightFactor: 1.0,
                //               child: IconButton(
                //                   onPressed: () async {
                //                     DateTime? newDate = await showDatePicker(
                //                       context: context,
                //                       initialDate: date,
                //                       firstDate: DateTime(1900),
                //                       lastDate: DateTime(2100),
                //                     );
                //                     if (newDate == null) return;
                //                     setState(
                //                       () => date = newDate,
                //                     );
                //                   },
                //                   icon: Icon(Icons.calendar_month)),
                //             ),
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(30.0),
                //             ),
                //           ))),
                // ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        DOBController.text = formattedDate;
                      });
                    } else {}
                  },
                  child: Container(
                      width: width / 2,
                      child: Center(
                          child: TextField(
                        controller: DOBController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          labelText: "Date of birth",
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now());

                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                            print(formattedDate);
                            setState(() {
                              DOBController.text = formattedDate;
                            });
                          } else {}
                        },
                      ))),
                ),
                Container(
                    width: width / 3,
                    child: TextField(
                        controller: AgeController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                          labelText: 'Age',
                          labelStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: "palatino",
                              color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ))),
              ],
            ),
            SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: DropdownButton(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Select Gender',
                          style: TextStyle(
                              fontFamily: 'palatino',
                              fontSize: 16,
                              color: Colors.grey),
                        )),
                      ],
                    ),
                    value: dropdownValueGender,
                    alignment: Alignment.centerLeft,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    elevation: 16,
                    style: const TextStyle(
                        fontFamily: 'palatino',
                        fontSize: 16,
                        color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueGender = newValue!;
                      });
                    },
                    items: dropdownValuesGender
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: DropdownButton(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Marital status',
                          style: TextStyle(
                              fontFamily: 'palatino',
                              fontSize: 16,
                              color: Colors.grey),
                        )),
                      ],
                    ),
                    value: dropdownValueMarital,
                    alignment: Alignment.centerLeft,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    elevation: 16,
                    style: const TextStyle(
                        fontFamily: 'palatino',
                        fontSize: 16,
                        color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueMarital = newValue!;
                      });
                    },
                    items: dropdownValuesMarital
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Container(
                child: TextField(
                    controller: UploadIDController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Photo Proof',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      suffixIcon: InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )),
                              padding: EdgeInsets.only(
                                  left: 90, top: 12, bottom: 12, right: 20),
                              width: 150,
                              child: Row(
                                children: [
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
                                        Icon(
                                          Icons.image_outlined,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 15),
                                        Text('Gallery',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20),
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
                        child: Container(
                          width: width / 3.5,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(15, 8, 30, 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            'Upload Photo',
                            style: TextStyle(
                                color: Colors.grey, fontFamily: 'palatino'),
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(
                child: TextField(
                    controller: EducationController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Educational Qualification',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(
                child: TextField(
                    controller: EmailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Email ID',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(
                child: TextField(
                    controller: MObileNOController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Mobile No',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(
                child: TextField(
                    controller: AlterMObileNOController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Alternative Mobile No',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(
                height: 50,
                width: 400,
                padding: EdgeInsets.all(0),
                child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(
                height: 50,
                width: 400,
                padding: EdgeInsets.all(0),
                child: TextField(
                    controller: ConfirmPasswordController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(
              height: 50,
              width: 400,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Professional',
                          style: TextStyle(
                              fontFamily: 'palatino',
                              fontSize: 16,
                              color: Colors.grey),
                        )),
                      ],
                    ),
                    value: professionalValue,
                    alignment: Alignment.centerLeft,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    // elevation: 16,
                    style: const TextStyle(
                        fontFamily: 'palatino',
                        fontSize: 16,
                        color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    items: dropdownValusProfessional
                        .map((item) => DropdownMenuItem<String>(
                              value: item['profession_id'],
                              child: Text(
                                '' + item['profession'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: "palatino",
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        professionalValue = value as String;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Container(
                height: 50,
                width: 400,
                padding: EdgeInsets.all(0),
                child: TextField(
                    controller: ProfessionalDetailsController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Professional Details',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(
              height: 50,
              width: 400,
              padding: EdgeInsets.all(0),
              child: TextField(
                  controller: SelectIDController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15.0, 0, 12, 0),
                    labelText: 'Select ID Proof',
                    labelStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: "palatino",
                        color: Colors.grey),
                    suffixIcon: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: DropdownButton2(
                          alignment: Alignment.centerRight,
                          value: idprofValue,
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          style: const TextStyle(
                              fontFamily: 'palatino',
                              fontSize: 16,
                              color: Colors.grey),
                          underline: Container(
                            height: 2,
                            color: Colors.grey,
                          ),
                          onChanged: (value) {
                            setState(() {
                              idprofValue = value as String;
                              Get.bottomSheet(
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                  padding: EdgeInsets.only(
                                      left: 90, top: 12, bottom: 12, right: 20),
                                  width: 150,
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            getImage(ImageSource.gallery),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Color(0xFF947BF5) // foreground
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
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      ElevatedButton(
                                        onPressed: () =>
                                            getImage(ImageSource.camera),
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
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                          items: dropdownValuesIDproff
                              .map((item) => DropdownMenuItem<String>(
                                    value: item['proof_name_id'],
                                    child: Text(
                                      '' + item['proof_name'],
                                      style: const TextStyle(
                                          fontSize: 16, fontFamily: 'palatino'),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  )),
            ),



            Column(
              children: [


                SizedBox(height: 18),
                Container(

                    child: TextField(
                        controller: CountryController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
                          labelText: 'Country',
                          labelStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: "palatino",
                              color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ))),
                SizedBox(height: 18),
                Container(

                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'State',
                      labelStyle: TextStyle(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        height: 16,
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        fontFamily: 'palatino',
                                        fontSize: 16,
                                        color: Colors.grey),
                                  )),
                            ],
                          ),
                          value: stateValue,
                          alignment: Alignment.centerLeft,
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(
                              fontFamily: 'palatino',
                              fontSize: 16,
                              color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.grey,
                          ),
                          items: dropdownValuesState
                              .map((item) => DropdownMenuItem<String>(
                            value: item['state_id'],
                            child: Text(
                              '' + item['state_name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "palatino",
                              ),
                            ),
                          ))
                              .toList(),
                          onChanged: (value) async{
                            print('123456');
                        await    getData2(value.toString());
                            setState(() {
                              stateValue = value as String;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Container(

                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'District',
                      labelStyle: TextStyle(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        height: 16,
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        fontFamily: 'palatino',
                                        fontSize: 16,
                                        color: Colors.grey),
                                  )),
                            ],
                          ),
                          value: districtValue,
                          alignment: Alignment.centerLeft,
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(
                              fontFamily: 'palatino',
                              fontSize: 16,
                              color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.grey,
                          ),
                          items: dropdownValuesDistrict
                              .map((item) => DropdownMenuItem<String>(
                            value: item['district_id'],
                            child: Text(
                              '' + item['district_name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "palatino",
                              ),
                            ),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              districtValue = value as String;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Container(


                    child: TextField(
                        controller: PincodeController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("[0-9]")),
                        ],
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
                          labelText: 'Pincode',
                          labelStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: "palatino",
                              color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ))),
                SizedBox(height: 18),
                Container(
                    child: TextField(
                        controller: CurrentController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
                          labelText: 'Current Address',
                          labelStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: "palatino",
                              color: Colors.grey),
                          suffixIcon: Checkbox(
                              value: box,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value!) {
                                    perdistrictValue = districtValue;
                                    PermanentController.text =
                                        CurrentController.text;
                                    PerPincodeController.text =
                                        PincodeController.text;
                                    perstateValue = stateValue;
                                    PerCountryController.text =
                                        CountryController.text;
                                  } else {
                                    perdistrictValue = null;
                                    PermanentController.clear();
                                    PerPincodeController.clear();
                                    perstateValue = null;
                                    PerCountryController.clear();
                                  }
                                  box = value;
                                });
                              }),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ))),
              ],
            ),
            SizedBox(height: 18),
            Container(
                width: width / 2.5,
                child: TextField(
                    controller: PerCountryController,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
                      labelText: 'Country',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(

              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'State',
                  labelStyle: TextStyle(),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: Container(
                    height: 16,
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                              child: Text(
                                '',
                                style: TextStyle(
                                    fontFamily: 'palatino',
                                    fontSize: 16,
                                    color: Colors.grey),
                              )),
                        ],
                      ),
                      value: perstateValue,
                      alignment: Alignment.centerLeft,
                      icon: const Icon(Icons.arrow_drop_down_outlined),
                      elevation: 16,
                      style: const TextStyle(
                          fontFamily: 'palatino',
                          fontSize: 16,
                          color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      items: dropdownValuesState
                          .map((item) => DropdownMenuItem<String>(
                        value: item['state_id'],
                        child: Text(
                          '' + item['state_name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "palatino",
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (value) async{
                        await    getData2(value.toString());
                        setState(() {
                          perstateValue = value as String;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),

            Container(

              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'District',
                  labelStyle: TextStyle(),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: Container(
                    height: 16,
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                              child: Text(
                                '',
                                style: TextStyle(
                                    fontFamily: 'palatino',
                                    fontSize: 16,
                                    color: Colors.grey),
                              )),
                        ],
                      ),
                      value: perdistrictValue,
                      alignment: Alignment.centerLeft,
                      icon: const Icon(Icons.arrow_drop_down_outlined),
                      elevation: 16,
                      style: const TextStyle(
                          fontFamily: 'palatino',
                          fontSize: 16,
                          color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      items: dropdownValuesDistrict
                          .map((item) => DropdownMenuItem<String>(
                        value: item['district_id'],
                        child: Text(
                          '' + item['district_name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "palatino",
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          perdistrictValue = value as String;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Container(

                child: TextField(
                    controller: PerPincodeController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp("[0-9]")),
                    ],
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
                      labelText: 'Pincode',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(
                child: TextField(
                    controller: PermanentController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
                      labelText: 'Permanent Address',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),




            SizedBox(height: 18),
            Container(
                child: TextField(
                    controller: IncomeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Per Month Income',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(
                child: TextField(
                    controller: ExperienceController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Experience',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(
                child: TextField(
                    controller: SkillController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Additional Knowledge / Skill',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 18),
            Container(
                child: TextField(
                    controller: JobController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      labelText: 'Current Situation / Job seeking if any',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "palatino",
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 6),
                  child: Row(
                    children: [
                      Text('Family Details',
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'palatino',
                              fontSize: 16)),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: OutlinedButton(
                    child: Text(
                      "Click to Fill Family Details",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomTextF(),
                          ));
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(12),
              // height: 40,
              // width: 40,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Checkbox(
                    value: this.value,
                    onChanged: (o) {
                      setState(() {
                        this.value = o!;
                      });
                    },
                  ),
                  SizedBox(width: 10), //SizedBox
                  SizedBox(
                    width: 250,
                    child: Text(
                      'I accept and agree to the terms and conditions  ',
                      style: TextStyle(fontSize: 16.0, color: Colors.red),
                    ),
                  ), //Text
                  //SizedBox

                  //Checkbox
                ], //<Widget>[]
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  child: OutlinedButton(
                    child: Text(
                      "Get OTP",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () {
                      print(DOBController.toString());
                      if (nameController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Enter Name');
                      } else if (MObileNOController.text.length != 10) {
                        Fluttertoast.showToast(
                            msg: 'Enter Valid Mobile Number');
                      } else if (!EmailController.text.isEmail) {
                        Fluttertoast.showToast(
                            msg: 'Enter valid email address');
                      } else if (passwordController.text.length != 6) {
                        Fluttertoast.showToast(
                            msg: 'Password must be 6 characters');
                      } else if (ConfirmPasswordController.text.length != 6) {
                        Fluttertoast.showToast(
                            msg: 'Confirm Password must be 6 characters');
                      } else if (passwordController.text !=
                          ConfirmPasswordController.text) {
                        Fluttertoast.showToast(
                            msg: "Password and confirmPassword did't match");
                      } else if (SelectIDController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Please attach id proof");
                      } else if (UploadIDController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please attach upload photo");
                      } else if (dropdownValueGender.toString() == 'null') {
                        Fluttertoast.showToast(msg: 'Please Select Gender');
                      } else {
                        getotp(MObileNOController.text);
                      }
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => Subscrip(),
                      //     ));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF947BF5)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ))),
                  ),
                ),
              ],
            ),
          ])),
    );
  }

  resetAll() {
    nameController.clear();
    DOBController.clear();
    AgeController.clear();
    GenderController.clear();
    UploadIDController.clear();
    EducationController.clear();
    EmailController.clear();
    MObileNOController.clear();
    AlterMObileNOController.clear();
    passwordController.clear();
    ConfirmPasswordController.clear();
    ProfessionalDetailsController.clear();
    SelectIDController.clear();
    CurrentController.clear();
    PincodeController.clear();
    PerCountryController.clear();
    IncomeController.clear();
    ExperienceController.clear();
    SkillController.clear();
    CurrentController.clear();
  }

  Future<void> getData() async {
    var url = 'http://bhramayogi.teckzy.co.in/User_api/profession';
    var finalurl = Uri.parse(url);
    var res = await http
        .get(finalurl, headers: <String, String>{'X-API-KEY': 'yogi@123'});
    var deCodedValue = json.decode(res.body);
    setState(() {
      dropdownValusProfessional = deCodedValue;
      // print(dropdownValusProfessional.toString());
    });
  }

  Future<void> getData1() async {
    var url = 'http://bhramayogi.teckzy.co.in/User_api/proof_name';
    var finalurl = Uri.parse(url);
    var res = await http
        .get(finalurl, headers: <String, String>{'X-API-KEY': 'yogi@123'});
    var deCodedValue = json.decode(res.body);
    setState(() {
      dropdownValuesIDproff = deCodedValue;
      // print(dropdownValuesIDproff.toString());
    });
  }

  Future<void> getData2(String id) async {
    var url = 'http://bhramayogi.teckzy.co.in/User_api/district';
    var body={
      "state":id
    };

    var finalurl = Uri.parse(url);
    var res = await http
        .post(finalurl, headers: <String, String>{'X-API-KEY': 'yogi@123'},body: body);
    print(res.body);

    var deCodedValue = json.decode(res.body);

    setState(() {
      dropdownValuesDistrict = deCodedValue;
      // print(dropdownValuesDistrict.toString());
    });
  }

  Future<void> getData3() async {
    var url = 'http://bhramayogi.teckzy.co.in/User_api/state';
    var finalurl = Uri.parse(url);
    var res = await http
        .get(finalurl, headers: <String, String>{'X-API-KEY': 'yogi@123'});
    var deCodedValue = json.decode(res.body);
    setState(() {
      dropdownValuesState = deCodedValue;
      // print(dropdownValuesState.toString());
    });
  }
}

BoxDecoration get _pinPutDecoration {
  return BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 3,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  );
}
