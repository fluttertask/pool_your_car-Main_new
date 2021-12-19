// ignore_for_file: must_call_super

import 'dart:convert';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pool_your_car/components/custom_surfix_icon.dart';

import '../../../size_config.dart';
import '../../../constants.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../components/default_button.dart';
import 'remaining_body_second.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemainingBodyOne extends StatefulWidget {
  @override
  // ignore: override_on_non_overriding_member
  static String routeName = "/offer_ride/components";
  final String pickuplocation;
  final String droplocation;
  final String date, time;
  // ignore: non_constant_identifier_names
  final String pickup_Lat, pickup_Lon, drop_Lat, drop_Lon;

  RemainingBodyOne({
    Key key,
    @required this.pickuplocation,
    @required this.droplocation,
    @required this.date,
    @required this.time,
    // ignore: non_constant_identifier_names
    @required this.pickup_Lat,
    // ignore: non_constant_identifier_names
    @required this.pickup_Lon,
    // ignore: non_constant_identifier_names
    @required this.drop_Lat,
    // ignore: non_constant_identifier_names
    @required this.drop_Lon,
  }) : super(key: key);

  @override
  _RemainingBodyOneState createState() => _RemainingBodyOneState();
}

class _RemainingBodyOneState extends State<RemainingBodyOne> {
  String sharedprefenrenceid;
  gettingSharedPreference() async {
    Future<SharedPreferences> preferences = SharedPreferences.getInstance();
    final SharedPreferences prefs = await preferences;
    final SharedPreferences emailprefs = await preferences;
    String userid = prefs.getString("user");
    String _email = emailprefs.get("email");

    print("Driver id in shared preference is " + json.decode(userid));
    print("Driver email in shared preference is " + json.decode(_email));
    sharedprefenrenceid = json.decode(userid);

    //GetUserDetails();
  }

  int seats = 1;
  String cartype;
  TextEditingController detailscontroller = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController veh_reg_number_controller = new TextEditingController();

  void _incrementPassenger() {
    if (seats < 4) {
      setState(() {
        seats++;
      });
    } else {
      setState(() {
        seats = 4;
      });
    }
  }

  void _decrementPassenger() {
    if (seats > 1) {
      setState(() {
        seats--;
      });
    }
  }

  @override
  void initState() {
    gettingSharedPreference();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        title: Text(
          "Offer Ride",
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Text(
                    "Ride Details",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "So how many passengers you can take?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Row(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          _decrementPassenger();
                        },
                        splashColor: Colors.white,
                        elevation: 2.0,
                        fillColor: kPrimaryColor,
                        child: Icon(
                          Icons.remove,
                          size: getProportionateScreenWidth(28),
                        ),
                        padding: EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      ),
                      Spacer(),
                      Text(
                        "$seats",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenWidth(25),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      RawMaterialButton(
                        onPressed: () {
                          _incrementPassenger();
                        },
                        splashColor: Colors.white,
                        elevation: 2.0,
                        fillColor: kPrimaryColor,
                        child: Icon(Icons.add,
                            size: getProportionateScreenWidth(28)),
                        padding: EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Select Car Type",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  dropDownCarSelection(),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Vehicle Registration Number",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  buildVehRegNumberFormField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Anything to add about your ride?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Optional***",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: getProportionateScreenWidth(16),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  TextFormField(
                    controller: detailscontroller,
                    minLines: 5,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText:
                            "Flexible about where \nand when to meet? \nNot taking the " +
                                "motorway?\nGot limited space in your \nboot?",
                        labelText: "Ride Restrictions",
                        labelStyle: TextStyle()),
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  DefaultButton(
                    text: "Next",
                    press: () {
                      //if (_formKey.currentState.validate()) {
                      //_formKey.currentState.save();

                      if (cartype == null) {
                        // Fluttertoast.showToast(
                        //   msg: "Select Car Type",
                        //   toastLength: Toast.LENGTH_LONG,
                        //   gravity: ToastGravity.BOTTOM,
                        //   backgroundColor: Colors.white,
                        //   textColor: kPrimaryColor,
                        //   fontSize: 20.0,
                        // );
                        CherryToast.error(
                          toastDuration: Duration(seconds: 2),
                          title: "",
                          enableIconAnimation: true,
                          displayTitle: false,
                          description: "Select Car Type",
                          toastPosition: POSITION.BOTTOM,
                          animationDuration: Duration(milliseconds: 500),
                          autoDismiss: true,
                        ).show(context);
                      } else if (this.veh_reg_number_controller.text.isEmpty) {
                        CherryToast.error(
                          toastDuration: Duration(seconds: 2),
                          title: "",
                          enableIconAnimation: true,
                          displayTitle: false,
                          description: "Select Car Type",
                          toastPosition: POSITION.BOTTOM,
                          animationDuration: Duration(milliseconds: 500),
                          autoDismiss: true,
                        ).show(context);
                      } else {
                        print(cartype);
                        print(this.veh_reg_number_controller.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RemainingBodySecond(
                              sharedprefenrenceid: this.sharedprefenrenceid,
                              pickuplocation: widget.pickuplocation,
                              pickup_Lat: widget.pickup_Lat,
                              pickup_Lon: widget.pickup_Lon,
                              droplocation: widget.droplocation,
                              drop_Lat: widget.drop_Lat,
                              drop_Lon: widget.drop_Lon,
                              date: widget.date,
                              time: widget.time,
                              cartype: this.cartype,
                              offeredseats: this.seats,
                              optional_details: this.detailscontroller.text,
                              vehicle_registration_number:
                                  this.veh_reg_number_controller.text,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  dropDownCarSelection() {
    return DropdownSearch<String>(
      validator: (v) => v == null ? "required field" : null,
      hint: "Select Car Type",
      mode: Mode.MENU,
      //showSelectedItem: true,

      //maxHeight: 70,
      //searchBoxDecoration: ,
      items: ["Hatchback Car", "Sedan Car", "Premium Car", "Wagon"],
      //label: "Menu mode *",
      showClearButton: true,
      onChanged: (value) {
        cartype = value;
        //print("si value is " + si);
      },
      //popupItemDisabled: (String s) => s.startsWith('I'),
      //selectedItem: ,
      // onBeforeChange: (a, b) {
      //   AlertDialog alert = AlertDialog(
      //     title: Text("Are you sure"),
      //     content: Text("...you want to clear the selection"),
      //     actions: [
      //       FlatButton(
      //         child: Text("OK"),
      //         onPressed: () {
      //           Navigator.of(context).pop(true);
      //         },
      //       ),
      //       FlatButton(
      //         child: Text("NOT OK"),
      //         onPressed: () {
      //           Navigator.of(context).pop(false);
      //         },
      //       ),
      //     ],
      //   );

      //   return showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return alert;
      //       });
      // },
    );
  }

  TextFormField buildVehRegNumberFormField() {
    return TextFormField(
      controller: veh_reg_number_controller,
      //keyboardType: TextInputType.emailAddress,
      //onSaved: (newValue) => email = newValue,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kEmailNullError);
      //   } else if (emailValidatorRegExp.hasMatch(value)) {
      //     removeError(error: kInvalidEmailError);
      //   }
      //   return null;
      // },
      // validator: (value) {
      //   if (value.isEmpty) {
      //     addError(error: kEmailNullError);
      //     return "";
      //   } else if (!emailValidatorRegExp.hasMatch(value)) {
      //     addError(error: kInvalidEmailError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        labelText: "Registration Number",
        labelStyle: TextStyle(
          fontSize: 18,
          //fontWeight: FontWeight.w700,
        ),
        hintText: "Enter Registration Number",
        hintStyle: TextStyle(
          fontSize: 18,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //   suffixIcon: SvgPicture.asset(
        //   "assets/icons/license-plate.svg",
        //   height: getProportionateScreenWidth(10),
        // ),
      ),
    );
  }
}
