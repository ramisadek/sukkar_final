import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

//shared data for app
class SharedData {
  static var customerData;
  static var tokenCustomer;
  static Map<String, dynamic> authUser;
}

SharedPreferences sharedPreferences;
//Get Customer Data
getCustomerData() async {
  sharedPreferences = await SharedPreferences.getInstance();
  SharedData.authUser = jsonDecode(sharedPreferences.getString("authUser"));
  if (sharedPreferences.get("authUser") != null) {
    SharedData.customerData = json.decode(sharedPreferences.get("authUser"));
  } else {
    SharedData.customerData = null;
  }
}
