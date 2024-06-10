import 'dart:convert';
import 'dart:io';
import 'package:brahmayogi/auth/EditProfile.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Family Details.dart';
import 'Homepage.dart';
import 'package:http/http.dart' as http;
import 'Loginpage.dart';

var profiledetails;

Showdataapi() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? memberid = prefs.getString('member_id');
  var url = Uri.parse('$baseurl/user_details');
  final response = await http.post(url, headers: <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
    'x-api-key': 'yogi@123'
  }, body: {
    'member_id': memberid.toString(),
  });
  var data = json.decode(response.body);
  if (data != null) {
    profiledetails = data[0];
  } else {}
  print('hey dude' + response.body.toString());
  print('hey d' + memberid.toString());
}

TextEditingController nameController = TextEditingController();
TextEditingController EmailController = TextEditingController();
TextEditingController MObileNOController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController ConfirmPasswordController = TextEditingController();
TextEditingController SelectIDController = TextEditingController();
TextEditingController UploadIDController = TextEditingController();
TextEditingController DOBController = TextEditingController();
TextEditingController AgeController = TextEditingController();
TextEditingController EducationController = TextEditingController();
TextEditingController CurrentController = TextEditingController();
TextEditingController PermanentController = TextEditingController();
TextEditingController ProfessionalDetailsController = TextEditingController();
TextEditingController ExperienceController = TextEditingController();
TextEditingController IncomeController = TextEditingController();
TextEditingController AlterMObileNOController = TextEditingController();
TextEditingController PincodeController = TextEditingController();
TextEditingController CountryController = TextEditingController();
TextEditingController PerPincodeController = TextEditingController();
TextEditingController PerCountryController = TextEditingController();
TextEditingController SkillController = TextEditingController();
TextEditingController JobController = TextEditingController();
TextEditingController DOJController = TextEditingController();
TextEditingController DOBupdatedCotroller = TextEditingController();
TextEditingController DOJupdatedCotroller = TextEditingController();

List<String> dropdownValuesGender = ['male', 'female'];

// List<String> dropdownValuesGender = ['male', 'Female'];
List<String> dropdownValuesMarital = ['married', 'unmarried'];
var seletedDate;
var dropdownValuesIDproff = [];
var dropdownValuesDistrict = [];
var dropdownValuesperdistrict = [];
var dropdownValuesState = [];
var dropdownValueperState = [];
var dropdownValusProfessional = [];
// var dropdownValuesMarital = [];
String? professionalValue;
String? idprofValue;
String? districtValue;
String? stateValue;
String? dropdownValueGender;
String? dropdownValueMarital;
String? perdistrictValue;
String? perstateValue;
File? _image;
File? _imageID;


void Updateapi() async {
  final uri = Uri.parse(baseurl + '/update_register');
  var request = http.MultipartRequest('POST', uri);


  request.headers.addAll(
    {
      "Content-type": "application/x-www-form-urlencoded",
      'x-api-key': 'yogi@123'
    },
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var memberid = prefs.getString('member_id');

  print(DOBController.text.toString()); print(DOJController.text.toString); print(memberid);
  request.fields['member_id'] = memberid.toString();
  // request.fields['doj'] = DOJupdatedCotroller.text;
  request.fields['join_date'] = DOJController.text.toString();
  request.fields['email'] = EmailController.text.toString();
  request.fields['whatsapp_no'] = MObileNOController.text.toString();
  request.fields['password'] = passwordController.text.toString();
  request.fields['password'] = ConfirmPasswordController.text.toString();
  request.fields['alter_mobileno'] = AlterMObileNOController.text.toString();
  request.fields['maried_status'] = dropdownValueMarital.toString();
  request.fields['dob'] = DOBController.text;
  request.fields['age'] = AgeController.text.toString();
  request.fields['gender'] = dropdownValueGender.toString();
  request.fields['name'] = nameController.text.toString();
  request.fields['family_details'] = json.encode(finalList);
  request.fields['qualification'] = EducationController.text.toString();
  request.fields['professional'] =
      professionalValue ?? profiledetails['professional'];
  request.fields['professional_deatils'] =
      ProfessionalDetailsController.text.toString();
  request.fields['cur_address'] = CurrentController.text.toString();
  request.fields['cur_pincode'] = PincodeController.text.toString();
  request.fields['cur_district'] =
      districtValue ?? profiledetails['cur_district'];
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
  print(request.fields);
  if(_image?.path!=null){
    print(978670);
var profileim=await http.MultipartFile.fromPath("photo",_image!.path);
request.files.add(profileim);
  }
  if(_imageID?.path!=null){
    print(978670);
    var idproof=await http.MultipartFile.fromPath("proof",_imageID!.path);
    request.files.add(idproof);
  }

  var response = await request.send();
  final respStr = await response.stream.bytesToString();
  var data = json.decode(respStr);
  print(data.toString());
  if (data['status'] == true) {
    Get.offAll(() => Home());
    Fluttertoast.showToast(msg: data['msg']);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var memberid = prefs.getString('member_id');
    String user = jsonEncode(data['user']);
    prefs.setString('Profile', user);
    Map userMap = jsonDecode(prefs.getString('Profile')!);
    ProfileModel user1 = ProfileModel.fromJson(userMap);
    print(user1);
  } else {
    Fluttertoast.showToast(msg: data['msg']);
  }
  print('response' + data.toString());
}

class profileeditpage extends StatelessWidget {
  const profileeditpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF947BF5),
        title: Text(
          "Edit Profile",
          style: TextStyle(fontSize: 22.0, fontFamily: "palatino"),
          textAlign: TextAlign.center,
        ),
      ),
      body: profileeditpages(),
    );
  }
}

class profileeditpages extends StatefulWidget {
  const profileeditpages({Key? key}) : super(key: key);

  @override
  State<profileeditpages> createState() => _profileeditpages();
}

class _profileeditpages extends State<profileeditpages> {
  var size, width, height;

  bool box = false;
  bool isHiddenPassword = true;
  bool isHiddenPassword1 = true;

  // DateTime date = DateTime(1900, 12, 24);
  DateTime date = DateTime(1900, 01, 01);

  Future profilegetImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);

    setState(() {
      Get.back();
      _image = imageTemporary;
      SelectIDController.text = _image!.path;
      print(_image!.path);
    });
  }

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      Get.back();
      _imageID = imageTemporary;
      SelectIDController.text = _imageID!.path;
      print(_imageID!.path);
    });
  }

  // Future getIDImage(ImageSource source) async {
  //   final image = await ImagePicker().pickImage(source: source);
  //   if (image == null) return;
  //   final imageTemporary = File(image.path);
  //   setState(() {
  //     Get.back();
  //    _imageID = imageTemporary;
  //     UploadIDController.text = _imageID!.path;
  //     print(_imageID!.path);
  //   });
  // }

  @override
  void initState() {
    namefunction();
    getData();
    getData1();
    // getData2();
    getData3();
    super.initState();
  }

  namefunction() async {
    try {
      await Showdataapi();

        loading = true;
        nameController.text = profiledetails['name'] ?? '';
        print('name===' + nameController.text);
        DOJController.text = profiledetails['join_date'] ?? '';
        AgeController.text = profiledetails['age'] ?? '';
        EmailController.text = profiledetails['email'] ?? '';
        print('Email:  ' + EmailController.text);
        MObileNOController.text = profiledetails['whatsapp_no'] ?? '';
        print(MObileNOController.text.toString());
        passwordController.text = profiledetails['password'] ?? '';
        print(passwordController.text.toString());
        ConfirmPasswordController.text = profiledetails['password'] ?? '';
        SelectIDController.text = profiledetails['proof'] ?? ' ';
        UploadIDController.text = profiledetails['photo'] ?? '';
        DOBController.text = profiledetails['dob'] ?? '';
        dropdownValueGender = profiledetails['gender'] ?? '';
        dropdownValueMarital = profiledetails['maried_status'] ?? '';
        EducationController.text = profiledetails['qualification'] ?? '';
        CurrentController.text = profiledetails['cur_address'] ?? '';
        PermanentController.text = profiledetails['per_address'] ?? '';
        professionalValue = profiledetails['professional'] ?? '';
        ProfessionalDetailsController.text =
            profiledetails['professional_deatils'] ?? '';
        ExperienceController.text = profiledetails['job_experience'] ?? '';
        IncomeController.text = profiledetails['salary'] ?? '';
        AlterMObileNOController.text = profiledetails['alter_mobileno'] ?? '';

        districtValue = profiledetails['cur_district_id'] ?? '';
        print('123323'+districtValue.toString());
        stateValue = profiledetails['cur_state'] ?? '';
        perdistrictValue = profiledetails['per_district_id'] ?? '';
        perstateValue = profiledetails['per_state'] ?? '';
        PincodeController.text = profiledetails['cur_pincode'] ?? '';
        CountryController.text = profiledetails['cur_country'] ?? '';
        PerPincodeController.text = profiledetails['per_pincode'] ?? '';
        PerCountryController.text = profiledetails['per_country'] ?? '';
        SkillController.text = profiledetails['skills'] ?? '';
        JobController.text = profiledetails['current_situation'] ?? '';
        setState(() {

        });
       await getData2(perstateValue.toString());
      setState(() {

      });
    } catch (ex) {
      Fluttertoast.showToast(msg: ex.toString());
    }
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: loading == true
          ? Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListView(children: <Widget>[
                SizedBox(height: 18),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          profiledetails == null
                              ? Expanded(
                                  child: CircleAvatar(
                                    radius: 65.0,
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(
                                      'assets/man (1).png',
                                    ),
                                  ),
                                )
                              : ClipOval(
                                  child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              child: PhotoView(
                                            imageProvider: NetworkImage(
                                                profiledetails['photo']!),
                                          ));
                                        });
                                  },
                                  child: _image!=null?Image.file(_image! ,height: 135,
                                      width: 135,
                                      fit: BoxFit.cover):Image.network(profiledetails['photo'],
                                      height: 135,
                                      width: 135,
                                      fit: BoxFit.cover),
                                )),
                          Positioned(
                            child: InkWell(
                              child: Icon(Icons.camera_alt),
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        )),
                                    padding: EdgeInsets.only(
                                        left: 90,
                                        top: 12,
                                        bottom: 12,
                                        right: 20),
                                    child: Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () => profilegetImage(
                                              ImageSource.gallery),
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
                                          onPressed: () => profilegetImage(
                                              ImageSource.camera),
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
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                    child: TextField(
                        controller: nameController,
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
                // InkWell(
                //   onTap: () async {
                //     DateTime? pickedDate = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(1950),
                //         lastDate: DateTime(2100));
                //     if (pickedDate != null) {
                //       String formattedDate =
                //           DateFormat('dd-MM-yyyy').format(pickedDate);
                //       setState(() {
                //         DOJController.text = formattedDate;
                //       });
                //     } else {}
                //   },
                //   child: Container(
                //       // width: width / 2,
                //       child: Center(
                //           child: TextField(
                //     controller: DOJController,
                //     decoration: InputDecoration(
                //       suffixIcon: Icon(Icons.calendar_today),
                //       labelText: "Date of joining",
                //       labelStyle: TextStyle(color: Colors.grey),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(30.0),
                //       ),
                //     ),
                //     onTap: () async {
                //       DateTime? pickedDate = await showDatePicker(
                //           context: context,
                //           initialDate: DateTime.now(),
                //           firstDate: DateTime(1950),
                //           lastDate: DateTime(2100));
                //       if (pickedDate != null) {
                //         print(pickedDate);
                //         String formattedDate =
                //             DateFormat('dd-MM-yyyy').format(pickedDate);
                //         print(formattedDate);
                //         setState(() {
                //           DOJController.text = formattedDate;
                //           DOJupdatedCotroller.text = DOJController.text;
                //         });
                //       }
                //       print(DOJController.text);
                //     },
                //   ))),
                // ),
                // Container(
                //     child:
                //     TextField(
                //         controller: DOJController,
                //         // enabled: false,
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                //           labelText: 'Date of joining',
                //           labelStyle: const TextStyle(
                //               fontSize: 16,
                //               fontFamily: "palatino",
                //               color: Colors.grey),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(30.0),
                //             borderSide: BorderSide(color: Colors.grey),
                //           ),
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(30.0),
                //           ),
                //         ))),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                          print('date of birth');

                          setState(() {
                            DOBController.text = formattedDate.toString();
                          });
                        }
                        print('dob:=  ' + DOBController.text);
                      },
                      child: Container(
                          width: width / 2,
                          child: Center(
                              child: TextField(
                            controller: DOBController,
                            // enabled: false,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today),
                              labelText: "Date of birth",
                              labelStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onTap: () async {
                              var covertedDate =
                                  DOBController.text.toString().split('-');
                              var finalDate = DateTime.parse(
                                  '${covertedDate[2]}-${covertedDate[1]}-${covertedDate[0]}');
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: finalDate,
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100));
                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                print(formattedDate);
                                setState(() {
                                  DOBController.text = formattedDate;
                                  DOBupdatedCotroller.text = DOBController.text;
                                });
                              } else {}
                            },
                          ))),
                    ),
                    // Container(
                    //     width: width / 2,
                    //     child: TextField(
                    //         controller: DOBController,
                    //         decoration: InputDecoration(
                    //           contentPadding:
                    //               EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                    //           labelText: 'Date of birth',
                    //           labelStyle: const TextStyle(
                    //               fontSize: 16,
                    //               fontFamily: "palatino",
                    //               color: Colors.grey),
                    //           suffixIcon: Align(
                    //             widthFactor: 1.0,
                    //             heightFactor: 1.0,
                    //             child: IconButton(
                    //                 onPressed: () async {
                    //                   DateTime? newDate = await showDatePicker(
                    //                     context: context,
                    //                     initialDate: date,
                    //                     firstDate: DateTime(1900),
                    //                     lastDate: DateTime(2100),
                    //                   );
                    //                   if (newDate == null) return;
                    //                   setState(() => date = newDate);
                    //                 },
                    //                 icon: Icon(Icons.calendar_month)),
                    //           ),
                    //           focusedBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(30.0),
                    //             borderSide: BorderSide(color: Colors.grey),
                    //           ),
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(30.0),
                    //           ),
                    //         ))),
                    SizedBox(width: 18),
                    Container(
                        width: width / 3,
                        child: TextField(
                            controller: AgeController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                              labelText: 'Age',
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
                  ],
                ),
                SizedBox(height: 18),
                // Container(
                //   width: width / 2.5,
                //   child: InputDecorator(
                //     decoration: InputDecoration(
                //       labelText: 'Select Gender',
                //       labelStyle: TextStyle(),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(30.0)),
                //     ),
                //     child: DropdownButtonHideUnderline(
                //       child: Container(
                //         height: 16,
                //         padding: EdgeInsets.only(right: 20, left: 20),
                //         child: DropdownButton(
                //           isExpanded: true,
                //           hint: Row(
                //             children: [
                //               Expanded(
                //                   child: Text(
                //                 '',
                //                 style: TextStyle(
                //                     fontFamily: 'palatino',
                //                     fontSize: 16,
                //                     color: Colors.grey),
                //               )),
                //             ],
                //           ),
                //           value: dropdownValueGender,
                //           alignment: Alignment.centerLeft,
                //           icon: const Icon(Icons.arrow_drop_down_outlined),
                //           elevation: 16,
                //           style: const TextStyle(
                //               fontFamily: 'palatino',
                //               fontSize: 16,
                //               color: Colors.black),
                //           underline: Container(
                //             height: 2,
                //             color: Colors.black,
                //           ),
                //           onChanged: (String? newValue) {
                //             setState(() {
                //               dropdownValueGender = newValue!;
                //             });
                //           },
                //           items: dropdownValuesGender
                //               .map<DropdownMenuItem<String>>((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(value),
                //             );
                //           }).toList(),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                //new
                Container(
                  width: width / 2.5,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Select Gender',
                      labelStyle: TextStyle(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        height: 16,
                        padding: EdgeInsets.only(right: 20, left: 20),
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
                ),
                SizedBox(height: 18),
                Container(
                  width: width / 2.5,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Marital status',
                      labelStyle: TextStyle(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        height: 16,
                        padding: EdgeInsets.only(right: 20, left: 20),
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
                ),
                // SizedBox(height: 18),
                // Container(
                //     child: TextField(
                //         controller: UploadIDController,
                //         // enabled: false,
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                //           labelText: 'Photo Proof',
                //           labelStyle: const TextStyle(
                //               fontSize: 16,
                //               fontFamily: "palatino",
                //               color: Colors.grey),
                //           suffixIcon: InkWell(
                //             onTap: () {
                //               Get.bottomSheet(
                //                 Container(
                //                   decoration: BoxDecoration(
                //                       color: Colors.white54,
                //                       borderRadius: BorderRadius.only(
                //                         topLeft: Radius.circular(20),
                //                         topRight: Radius.circular(20),
                //                       )),
                //                   padding: EdgeInsets.only(
                //                       left: 90, top: 12, bottom: 12, right: 20),
                //                   width: 150,
                //                   child: Row(
                //                     children: [
                //                       ElevatedButton(
                //                         onPressed: () =>
                //                             getIDImage(ImageSource.gallery),
                //                         // color: Color(0xFF947BF5),
                //                         style: ElevatedButton.styleFrom(
                //                             backgroundColor:
                //                                 Color(0xFF947BF5) // foreground
                //                             ),
                //                         child: Row(
                //                           children: [
                //                             Icon(
                //                               Icons.image_outlined,
                //                               color: Colors.white,
                //                             ),
                //                             SizedBox(width: 15),
                //                             Text('Gallery',
                //                                 style: TextStyle(
                //                                     color: Colors.white)),
                //                           ],
                //                         ),
                //                       ),
                //                       SizedBox(width: 20),
                //                       ElevatedButton(
                //                         onPressed: () =>
                //                             getIDImage(ImageSource.camera),
                //                         style: ElevatedButton.styleFrom(
                //                             backgroundColor:
                //                                 Color(0xFF947BF5) // foreground
                //                             ),
                //                         // color: Color(0xFF947BF5),
                //                         child: Row(
                //                           children: [
                //                             Icon(Icons.camera_alt_outlined,
                //                                 color: Colors.white),
                //                             SizedBox(width: 15),
                //                             Text('Camera',
                //                                 style: TextStyle(
                //                                     color: Colors.white)),
                //                           ],
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             },
                //             child: Container(
                //               width: width / 3,
                //               alignment: Alignment.center,
                //               margin: EdgeInsets.fromLTRB(0, 8, 30, 8),
                //               decoration: BoxDecoration(
                //                 border: Border.all(color: Colors.grey),
                //               ),
                //               child: Text(
                //                 'Upload Photo',
                //                 style: TextStyle(
                //                     color: Colors.grey, fontFamily: 'palatino'),
                //               ),
                //             ),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(30.0),
                //             borderSide: BorderSide(color: Colors.grey),
                //           ),
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(30.0),
                //           ),
                //         ))),
                SizedBox(height: 18),
                Container(
                    width: width / 2.5,
                    padding: EdgeInsets.all(0),
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
                    width: width / 2.5,
                    child: TextField(
                        controller: EmailController,
                        enabled: true,
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
                    width: width / 2.5,
                    child: TextField(
                        controller: MObileNOController,
                        // enabled: false,
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
                    width: width / 2.5,
                    child: TextField(
                        controller: AlterMObileNOController,
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
                    width: width / 2.5,
                    child: TextField(
                        controller: passwordController,
                        // enabled: false,
                        obscureText: isHiddenPassword,
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
                    width: width / 2.5,
                    child: TextField(
                        controller: ConfirmPasswordController,
                        enabled: true,
                        obscureText: isHiddenPassword1,
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
                  height: height / 12,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Professional',
                      labelStyle: TextStyle(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        height: 20,
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                profiledetails['professional'],
                                style: TextStyle(
                                    fontFamily: 'palatino',
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                            ],
                          ),
                          value: professionalValue,
                          alignment: Alignment.centerLeft,
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          style: const TextStyle(
                              fontFamily: 'palatino',
                              fontSize: 16,
                              color: Colors.black),
                          underline: Container(
                            height: 3,
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
                ),
                SizedBox(height: 18),
                Container(
                    width: width / 2.5,
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
                  width: width / 2.5,
                  child: TextField(
                      controller: SelectIDController,
                      // enabled: false,
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
                                          left: 90,
                                          top: 12,
                                          bottom: 12,
                                          right: 20),
                                      width: 150,
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () =>
                                                getImage(ImageSource.gallery),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(
                                                    0xFF947BF5) // foreground
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
                                                backgroundColor: Color(
                                                    0xFF947BF5) // foreground
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
                                              fontSize: 16,
                                              fontFamily: 'palatino'),
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
                SizedBox(height: 18),
                Container(
                    width: width / 2.5,
                    child: TextField(
                        controller: CurrentController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
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
                SizedBox(height: 18),
                Container(
                    width: width,
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
                Column(
                  children: [

                    Container(
                      width: width,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'State',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Container(
                            height: 16,
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        profiledetails['cur_state'].toString(),
                                        style: TextStyle(
                                            fontFamily: 'palatino',
                                            fontSize: 16,
                                            color: Colors.black),
                                      )),
                                ],
                              ),
                              value: stateValue,
                              alignment: Alignment.centerLeft,
                              icon: const Icon(
                                  Icons.arrow_drop_down_outlined),
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
                              await  getData2(value.toString());
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
                      width: width ,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'District',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Container(
                            height: 16,
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    profiledetails['cur_district'],
                                    style: TextStyle(
                                        fontFamily: 'palatino',
                                        fontSize: 16,
                                        color: Colors.black),
                                  )),
                                ],
                              ),
                              value: districtValue,
                              alignment: Alignment.centerLeft,
                              icon: const Icon(
                                  Icons.arrow_drop_down_outlined),
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
                        width: width,
                        child: TextField(
                            controller: PincodeController,
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


                  ],
                ),

                SizedBox(height: 18),
                Container(
                    width: width / 2.5,
                    child: TextField(
                        controller: PermanentController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
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


                Column(
                  children: [
                    Container(
                        width: width ,
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
                      width: width ,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'State',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Container(
                            height: 16,
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        profiledetails['per_state'],
                                        style: TextStyle(
                                            fontFamily: 'palatino',
                                            fontSize: 16,
                                            color: Colors.black),
                                      )),
                                ],
                              ),
                              value: perstateValue,
                              alignment: Alignment.centerLeft,
                              icon: const Icon(
                                  Icons.arrow_drop_down_outlined),
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
                                await  getData2(value.toString());
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
                      width: width ,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'District',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Container(
                            height: 16,
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        profiledetails['per_district'],
                                        style: TextStyle(
                                            fontFamily: 'palatino',
                                            fontSize: 16,
                                            color: Colors.black),
                                      )),
                                ],
                              ),
                              value: perdistrictValue,
                              alignment: Alignment.centerLeft,
                              icon: const Icon(
                                  Icons.arrow_drop_down_outlined),
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
                        width: width ,
                        child: TextField(
                            controller: PerPincodeController,
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













                  ],
                ),

                SizedBox(height: 18),
                Container(
                    width: width,
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
                    width: width,
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
                SizedBox(height: 22),
                Container(
                    width: width ,
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
                    width: width / 2.5,
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //       padding: EdgeInsets.only(left: 6),
                //       child: Row(
                //         children: [
                //           Text('Family Details',
                //               style: TextStyle(
                //                   color: Colors.grey,
                //                   fontFamily: 'palatino',
                //                   fontSize: 16)),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       height: 40,
                //       child: OutlinedButton(
                //         child: Text(
                //           "Click to Fill Family Details",
                //           style: TextStyle(fontSize: 16, color: Colors.grey),
                //         ),
                //         onPressed: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => FamilyDetails(
                //                     familydetail:
                //                         profiledetails['family_details']),
                //               ));
                //         },
                //         style: ButtonStyle(
                //             shape: MaterialStateProperty.all(
                //                 RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(30.0),
                //         ))),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      child: OutlinedButton(
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        onPressed: () {
                          if (nameController.text.isEmpty) {
                            Fluttertoast.showToast(msg: 'Enter Name');
                          } else if (MObileNOController.text.length != 10) {
                            Fluttertoast.showToast(
                                msg: 'Enter Valid Mobile Number');
                          } else if (!EmailController.text.isEmail) {
                            Fluttertoast.showToast(
                                msg: 'Enter valid email address');
                          } else if (SelectIDController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please attach id proof");
                          } else if (UploadIDController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please attach upload photo");
                          } else if (dropdownValueGender.toString() == 'null') {
                            Fluttertoast.showToast(msg: 'Please Select Gender');
                          } else {
                            //loginapi();
                            Updateapi();
                          }
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ))),
                      ),
                    ),
                  ],
                ),
              ]))
          : Center(child: CircularProgressIndicator()),
    );
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
      isHiddenPassword1 = !isHiddenPassword1;
    });
  }

  Future<void> getData() async {
    var url = 'http://bhramayogi.teckzy.co.in/User_api/profession';
    var finalurl = Uri.parse(url);
    var res = await http
        .get(finalurl, headers: <String, String>{'X-API-KEY': 'yogi@123'});
    var deCodedValue = json.decode(res.body);
    setState(() {
      dropdownValusProfessional = deCodedValue;
      print(dropdownValusProfessional.toString());
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
      print(dropdownValuesIDproff.toString());
    });
  }

  Future<void> getData2( String id) async {
    var url = 'http://bhramayogi.teckzy.co.in/User_api/district';
    var body={
      "state":id
    };
    print(body);
    print(12345);
    var finalurl = Uri.parse(url);
    var res = await http
        .post(finalurl, headers: <String, String>{'X-API-KEY': 'yogi@123'},body: body);
    var deCodedValue = json.decode(res.body);
    setState(() {
      dropdownValuesDistrict = deCodedValue;
      print(dropdownValuesDistrict.toString());
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
      print(dropdownValuesState.toString());
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
