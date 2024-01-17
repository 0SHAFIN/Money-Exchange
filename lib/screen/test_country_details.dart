import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inso_cur/components/roundButton.dart';
import 'package:inso_cur/service/country.dart';

class Test_countryDetails extends StatefulWidget {
  const Test_countryDetails({super.key});

  @override
  State<Test_countryDetails> createState() => _Test_countryDetailsState();
}

Future<dynamic> getInfo() async {
  var data;
  final response =
      await http.get(Uri.parse("https://restcountries.com/v3.1/all"));
  if (response.statusCode == 200) {
    data = jsonDecode(response.body);
    return data;
  } else {
    throw ("error");
  }
}

var data2;

Future getRate() async {
  final response2 =
      await http.get(Uri.parse('https://open.er-api.com/v6/latest/USD'));

  if (response2.statusCode == 200) {
    data2 = jsonDecode(response2.body);
  } else {
    throw ('Error');
  }
}

class _Test_countryDetailsState extends State<Test_countryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRate();
  }

  @override
  Widget build(BuildContext context) {
    var rate;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: getInfo(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        print("data found");

                        return ListView.builder(itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: Image.network(
                                snapshot.data[index]["flags"]["png"],
                                height: 35,
                                width: 35,
                              ),
                              title:
                                  Text(snapshot.data[index]["name"]["common"]),
                              subtitle: Text("Currency: " +
                                  snapshot.data[index]["currencies"]
                                      .toString()
                                      .substring(1, 4)),
                              trailing: Text(data2["rates"][snapshot.data[index]
                                          ["currencies"]
                                      .toString()
                                      .substring(1, 4)]
                                  .toString()),
                            ),
                          );
                        });
                      } else {
                        print("data not found");
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                    })),
            roundButton(
                title: "Back",
                ontap: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
