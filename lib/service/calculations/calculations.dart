import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class mainCalcuations with ChangeNotifier {
  double amounT = 0;
  String? amountString;
  var data;
  void calculationsss(String cname1, String cname2, String amount) async {
    print(cname1.toString());
    print(cname2);
    print("from cal");
    var response =
        await http.get(Uri.parse("https://open.er-api.com/v6/latest/USD"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    }
    try {
      amounT = double.parse(amount);
      amounT = amounT / data["rates"][cname1];
      amounT = amounT * data["rates"][cname2];
      amountString = amounT.toStringAsFixed(3);
      notifyListeners();
    } catch (e) {
      print("error");
    }
  }
}
