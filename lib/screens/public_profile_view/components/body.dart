import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pool_your_car/components/default_button.dart';
import 'package:pool_your_car/models/GetUserResponseModel.dart';
import 'package:pool_your_car/size_config.dart';

import '../../../constants.dart';

import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  final String userid;
  Body({
    Key key,
    @required this.userid,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String id = "";
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';

  bool email_verified = false;
  bool image_is_uploaded = false;
  String user_profile_image_url;

  Future<GetUserResponseModel> GetUserDetails() async {
    print("object");
    print(widget.userid);
    final response = await http
        .get(Uri.parse("https://$myip/api/getsingleuser/${widget.userid}"));
    if (response.statusCode == 200) {
      print("Now Getting user data in profile details screen");
      print(jsonDecode(response.body));
      print("//");
      Map<String, dynamic> responseJson = json.decode(response.body);
      // ignore: unused_local_variable
      var _user = json.decode(response.body);
      //json.decode(response.body).cast<ObjectName>();
      var user = GetUserResponseModel.fromJson(jsonDecode(response.body));
      print("after storing to object ");
      setState(() {
        this.id = responseJson['_id'];
        this.firstName = responseJson['firstname'];
        this.lastName = responseJson['lastname'];
        this.email = responseJson['email'];
        this.phoneNumber = responseJson['phonenumber'];
        //this.email_verified = responseJson['emailverified'];
        if (responseJson['emailverified'] == true) {
          this.email_verified = true;
        }

        if (responseJson['profile_image_url'] != null) {
          this.user_profile_image_url = responseJson['profile_image_url'];
          print("Printing image url");
          print(this.user_profile_image_url);
          setState(() {
            this.image_is_uploaded = true;
          });
          // print(url[0]);
        }
      });

      //print(responseJson['email']);
      return GetUserResponseModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: CircleAvatar(
                backgroundImage: this.image_is_uploaded
                    ? NetworkImage(
                        "http://$myip:3000/images/${this.user_profile_image_url}")
                    : AssetImage("assets/images/Profile Image.png"),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.06),
            Row(
              children: [
                Text(
                  "First Name",
                  style: TextStyle(
                    //fontSize: getProportionateScreenWidth(10),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "$firstName",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(15),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            //SizedBox(height: SizeConfig.screenHeight * 0.02),
            Divider(thickness: 1.5, color: kPrimaryColor),
            SizedBox(height: SizeConfig.screenHeight * 0.02),

            Row(
              children: [
                Text(
                  "Last Name",
                  style: TextStyle(
                    //fontSize: getProportionateScreenWidth(10),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "$lastName",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(15),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            //SizedBox(height: SizeConfig.screenHeight * 0.02),
            Divider(thickness: 1.5, color: kPrimaryColor),
            SizedBox(height: SizeConfig.screenHeight * 0.02),

            Row(
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                    //fontSize: getProportionateScreenWidth(10),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '$email',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(15),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1.5, color: kPrimaryColor),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            // Row(
            //   children: [
            //     Text(
            //       "Send Message",
            //       style: TextStyle(
            //         color: kPrimaryColor,
            //         //fontSize: getProportionateScreenWidth(10),
            //         fontWeight: FontWeight.w700,
            //       ),
            //     ),
            //   ],
            // ),
            DefaultButton(
              text: "Send Message",
              press: () {},
            ),

            SizedBox(height: SizeConfig.screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
