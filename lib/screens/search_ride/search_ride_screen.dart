import 'package:flutter/material.dart';
import 'components/body.dart';
import '../../constants.dart';

class SearchRideScreen extends StatelessWidget {
  static String routeName = "/search_ride";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        title: Text(
          "Search Ride",
        ),
      ),
      body: Body(),
    );
  }
}
