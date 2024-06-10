import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple[400],
        title: Text(
          "Contact Us",style: TextStyle(fontSize: 22.0, fontFamily: "palatino"),
          textAlign: TextAlign.center,
        ),
      ),
      body: Contactus(),
    );
  }
}

class Contactus extends StatefulWidget {
  Contactus({Key? key}) : super(key: key);

  @override
  State<Contactus> createState() => _Contactuspage();
}

class _Contactuspage extends State<Contactus> {

  @override
  Widget build(BuildContext context)
  {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            color: Color(0xFFDCE8EE),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  width: 385,
                  height: 550,
                  color: Colors.white,
                  child: Text("Loren ipsum dolor sit amet, consetetur sadipscring elitr, sed diam nonumy", style: TextStyle(fontSize: 14, fontFamily: 'palatino')),
                ),
              ],
            ),
          );
        } );
  }
}

