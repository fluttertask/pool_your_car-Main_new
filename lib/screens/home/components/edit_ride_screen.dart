import 'package:flutter/material.dart';
import '../../../constants.dart';
class EditRideScreen extends StatelessWidget {
  final String day; //=
  //DateFormat('EEE, M/d/y').format(DateT ime.now()); //EEE, M/d/y
  final String time; //= DateFormat('hh:mm:a').format(DateTime.now()); //hh:mm:a
  final String fromlocation, tolocation;
  final String ridetype;
  final String image;
  final String drivername;
  final int cashamount;
  final String cartype;
  final bookedseats;
  final int discount;
  EditRideScreen({
    Key key,
    @required this.day,
    @required this.time,
    @required this.fromlocation,
    @required this.tolocation,
    @required this.ridetype,
    this.image,
    this.drivername,
    this.cashamount,
    this.cartype,
    this.bookedseats,
    @required this.discount,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        title: Text("Edit Ride"),
      ),
      
    );
  }
}