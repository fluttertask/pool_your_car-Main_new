import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../constants.dart';
import 'package:pool_your_car/components/custom_surfix_icon.dart';
import 'package:pool_your_car/components/form_error.dart';
import 'package:pool_your_car/components/default_button.dart';

import '../../../size_config.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  @override
  _ChangePhoneNumberScreenState createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phonenumbercontroller = new TextEditingController();

  String newphonenumber;
  @override
  final List<String> errors = [];
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        title: Text("Edit Phone Number"),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text("Edit Phone Number", style: headingStyle),
                  SizedBox(height: getProportionateScreenHeight(50)),
                  buildnewPhoneNumberFormField(),
                  FormError(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  DefaultButton(
                    text: "Save",
                    press: () {
                      if (_formKey.currentState.validate()) {
                        //Navigator.pushNamed(context, OtpScreen.routeName);
                        print("Alright");
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(40)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IntlPhoneField buildnewPhoneNumberFormField() {
    return IntlPhoneField(
      //onSaved: (PhoneNumber newValue) => _phoneNumber = newValue,
      onChanged: (value) {
        if (value.toString().isEmpty) {
          removeError(error: kPhoneNumberNullError);
        }else{
          setState(() {
            newphonenumber=value.completeNumber;
          });
          print("new phone is");
          print(newphonenumber); 
        }
        // return print(newphonenumber);
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: "Enter your phone number",
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
      initialCountryCode: 'PK',

      // onChanged: (phone) {
      //   print(phone.completeNumber);
      // },
    );
  }
}
