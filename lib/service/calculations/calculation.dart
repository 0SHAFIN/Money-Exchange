import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inso_cur/service/country.dart';

class calculation with ChangeNotifier {
  double? exchangedprice;
  String? changedamount;
  String? changedCurrency;
  String? result;
  var data;
  String? _ccode1;
  String? _ccode2;
  var data2;

  calculations(String amount, String countrynam1, String countrynam2) async {
    print(countrynam1);
    print(countrynam2);
    _ccode1 = Country().Countrydetails2[countrynam1];
    _ccode2 = Country().Countrydetails2[countrynam2];
    print("Country code 1: " + _ccode1.toString());
    print("Country code 2: " + _ccode2.toString());
    final response2 =
        await http.get(Uri.parse('https://open.er-api.com/v6/latest/USD'));

    if (response2.statusCode == 200) {
      data2 = jsonDecode(response2.body);

      notifyListeners();
    } else {
      throw ('Error');
    }
    double tempamount = double.parse(amount);

    print(tempamount);
    tempamount = tempamount / data2['rates'][_ccode1];
    tempamount = tempamount * data2['rates'][_ccode2];
    print(tempamount);

    changedCurrency = _ccode2;

    result = tempamount.toStringAsFixed(3);
    print("Result: " + result.toString());
    notifyListeners();
  }
}
