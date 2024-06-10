import 'package:brahmayogi/Screens/Registerpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FamilyDetails extends StatefulWidget {
  var familydetail;
  FamilyDetails({Key? key, this.familydetail}) : super(key: key);

  @override
  State<FamilyDetails> createState() => _FamilyDetailsState();
}

class _FamilyDetailsState extends State<FamilyDetails> {
  @override
  void initState() {
    print(widget.familydetail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF947BF5),
        title: Text(
          "Family Details",
          style: TextStyle(fontSize: 22.0, fontFamily: "palatino"),
          textAlign: TextAlign.center,
        ),
      ),
      body: Familydetail(familydetail: widget.familydetail),
    );
  }
}

var finalList = [];
int findex = -1;

class Familydetail extends StatefulWidget {
  var familydetail;
  Familydetail({Key? key, this.familydetail}) : super(key: key);

  @override
  State<Familydetail> createState() => _FamilydetailState();
}

class _FamilydetailState extends State<Familydetail> {
  List<DynamicItem> DynamicList = [];
  List<String> data = [];

  Icon floatingIcon = new Icon(Icons.add);
  // String? familydetail;
  // _FamilydetailState(this.familydetail);

  addDynamic() {
    if (data.length != 0) {
      floatingIcon = new Icon(Icons.add);
      data = [];
      DynamicList = [];
    }
    setState(() {});
    if (DynamicList.length >= 5) {
      return;
    }
    DynamicList.add(new DynamicItem());
    setState(() {});
  }

  @override
  void initState() {
    print(widget.familydetail);
    print(finalList);
    finalList = widget.familydetail;
    if (finalList.length != 0) {
      for (int i = 0; i < finalList.length; i++) {
        findex = i;
        DynamicList.add(new DynamicItem());
      }
    } else {
      DynamicList.add(new DynamicItem());
    }
    setState(() {});
    super.initState();
  }

  var objData = {};

  submitData() {
    finalList.clear();
    DynamicList.forEach((widget) {
      finalList.add({
        'name': widget.Namecontroller.text.toString(),
        'age': widget.familyAgeController.text.toString(),
        'relationship': widget.RelationshipController.text.toString(),
        'contact': widget.ContactController.text.toString(),
        'remark': widget.RemarkController.text.toString(),
      });
    });
    print(finalList.toString());
  }

  @override
  Widget build(BuildContext context) {
    Widget result = new Flexible(
        flex: 1,
        child: new Card(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      child: new Text("${index + 1} : ${data[index]}"),
                    ),
                    new Divider()
                  ],
                ),
              );
            },
          ),
        ));
    Widget dynamicTextField = new Flexible(
      flex: 2,
      child: new ListView.builder(
        itemCount: DynamicList.length,
        itemBuilder: (_, index) => DynamicList[index],
      ),
    );
    Widget submitBtn = new Container(
      child: new OutlinedButton(
        onPressed: () {
          if (finalList.toString() == 'null') {
            Fluttertoast.showToast(msg: 'Family details is empty');
          } else {
            (submitData());
            Navigator.pop(context);
          }
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ))),
        child: new Text(
          'Save',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Container(
          margin: new EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              data.length == 0 ? dynamicTextField : result,
              data.length == 0 ? submitBtn : Container(),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: addDynamic,
          child: floatingIcon,
          backgroundColor: Color(0xFF947BF5),
        ),
      ),
    );
  }
}

class DynamicItem extends StatelessWidget {
  // TextEditingController Namecontroller = TextEditingController(
  //     text: findex == -1 ? '' : finalList[findex]['name']);

  TextEditingController Namecontroller = TextEditingController(
      text: findex == -1 ? '' : finalList[findex]['name']);

  TextEditingController familyAgeController =
      TextEditingController(text: findex == -1 ? '' : finalList[findex]['age']);
  TextEditingController RelationshipController = TextEditingController(
      text: findex == -1 ? '' : finalList[findex]['relationship']);
  TextEditingController ContactController = TextEditingController(
      text: findex == -1 ? '' : finalList[findex]['contact']);
  TextEditingController RemarkController = TextEditingController(
      text: findex == -1 ? '' : finalList[findex]['remark']);

  TextEditingController updatedNamecontroller = TextEditingController();
  TextEditingController updatedfamilyAgeController = TextEditingController();
  TextEditingController updatedRelationshipcontroller = TextEditingController();
  TextEditingController updatedContactController = TextEditingController();
  TextEditingController updatedRemarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('Name:- ' + Namecontroller.text.toString());
    print('age:- ' + familyAgeController.text.toString());
    print('relationship:- ' + RelationshipController.text.toString());
    print('contact:- ' + ContactController.text.toString());
    print('remark:- ' + RemarkController.text.toString());
    updatedNamecontroller = TextEditingController();
    updatedfamilyAgeController = TextEditingController();
    updatedRelationshipcontroller = TextEditingController();
    updatedContactController = TextEditingController();
    updatedRemarkController = TextEditingController();
    findex = -1;
    return Container(
      child: ListBody(
        children: <Widget>[
          Container(
            child: TextField(
                controller: Namecontroller,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                ],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                      fontSize: 16, fontFamily: "palatino", color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                )),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  width: 170,
                  padding: EdgeInsets.all(0),
                  child: TextField(
                      controller: familyAgeController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      ],
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
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
              Container(
                  width: 170,
                  padding: EdgeInsets.all(0),
                  child: TextField(
                      controller: RelationshipController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
                        labelText: 'Relationship',
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
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 170,
                  padding: EdgeInsets.all(0),
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: ContactController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      ],
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
                        labelText: 'Contact No',
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
              SizedBox(width: 18),
              Container(
                  width: 170,
                  padding: EdgeInsets.all(0),
                  child: TextField(
                      controller: RemarkController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
                        labelText: 'Remarks',
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
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class Item {
  final String id;
  final String name;

  Item(this.id, this.name);
}

var familyList = [];

class CustomTextF extends StatefulWidget {
  const CustomTextF({Key? key}) : super(key: key);

  @override
  State<CustomTextF> createState() => _CustomTextFState();
}

class _CustomTextFState extends State<CustomTextF> {
  var _namecontrollers = [];
  var _agecontrollers = [];
  var _relationcontrollers = [];
  var _contactcontrollers = [];
  var _remarkscontrollers = [];

  var count = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF947BF5),
          title: Text(
            "Family Details",
            style: TextStyle(fontSize: 22.0, fontFamily: "palatino"),
            textAlign: TextAlign.center,
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              count++;
              setState(() {});
            }),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: count,
                    itemBuilder: (BuildContext context, int index) {
                      _namecontrollers.add(TextEditingController());
                      _agecontrollers.add(new TextEditingController());
                      _relationcontrollers.add(TextEditingController());
                      _contactcontrollers.add(TextEditingController());
                      _remarkscontrollers.add(TextEditingController());
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 500,
                            child: TextField(
                                controller: _namecontrollers[index],
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-z A-Z]")),
                                ],
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(15.0, 0, 0, 0),
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
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  width: 170,
                                  padding: EdgeInsets.all(0),
                                  child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _agecontrollers[index],
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            15.0, 15.0, 0, 15.0),
                                        labelText: 'Age',
                                        labelStyle: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "palatino",
                                            color: Colors.grey),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ))),
                              Container(
                                  width: 170,
                                  padding: EdgeInsets.all(0),
                                  child: TextField(
                                      controller: _relationcontrollers[index],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            15.0, 15.0, 0, 15.0),
                                        labelText: 'Relationship',
                                        labelStyle: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "palatino",
                                            color: Colors.grey),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ))),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  width: 170,
                                  padding: EdgeInsets.all(0),
                                  child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _contactcontrollers[index],
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            15.0, 15.0, 0, 15.0),
                                        labelText: 'Contact No',
                                        labelStyle: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "palatino",
                                            color: Colors.grey),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ))),
                              Container(
                                  width: 170,
                                  padding: EdgeInsets.all(0),
                                  child: TextField(
                                      controller: _remarkscontrollers[index],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            15.0, 15.0, 0, 15.0),
                                        labelText: 'Remarks',
                                        labelStyle: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "palatino",
                                            color: Colors.grey),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ))),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Container(
                          //     child: TextField(
                          //   textAlign: TextAlign.start,
                          //   controller: _namecontrollers[index],
                          //   autofocus: false,
                          //   keyboardType: TextInputType.text,
                          // )),
                          // Container(
                          //     child: TextField(
                          //   textAlign: TextAlign.start,
                          //   controller: _agecontrollers[index],
                          //   autofocus: false,
                          //   keyboardType: TextInputType.text,
                          // )),
                        ],
                      );
                    }),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF947BF5),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextButton(
                      onPressed: () {
                        familyList.clear();
                        for (var v = 0; v < count; v++) {
                          if ((_namecontrollers[v] as TextEditingController)
                                  .text
                                  .isNotEmpty &&
                              (_agecontrollers[v] as TextEditingController)
                                  .text
                                  .isNotEmpty &&
                              (_contactcontrollers[v] as TextEditingController)
                                  .text
                                  .isNotEmpty &&
                              (_remarkscontrollers[v] as TextEditingController)
                                  .text
                                  .isNotEmpty &&
                              (_relationcontrollers[v] as TextEditingController)
                                  .text
                                  .isNotEmpty) {
                            familyList.add({
                              'name':
                                  (_namecontrollers[v] as TextEditingController)
                                      .text,
                              'age':
                                  (_agecontrollers[v] as TextEditingController)
                                      .text,
                              'relationship': (_relationcontrollers[v]
                                      as TextEditingController)
                                  .text,
                              'contact': (_contactcontrollers[v]
                                      as TextEditingController)
                                  .text,
                              'remark': (_remarkscontrollers[v]
                                      as TextEditingController)
                                  .text,
                            });
                          } else {
                            Fluttertoast.showToast(msg: 'Enter all details');
                          }
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => registerpage()),
                        );
                        print(familyList.toString());
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
