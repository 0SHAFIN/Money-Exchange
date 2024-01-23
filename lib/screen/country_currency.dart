import 'dart:convert';

import 'package:countries_flag/countries_flag.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inso_cur/service/country.dart';

class CountryDetailsList extends StatefulWidget {
  const CountryDetailsList({super.key});

  @override
  State<CountryDetailsList> createState() => CountryListState();
}

class CountryListState extends State<CountryDetailsList> {
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

  String? url;
  var searchController = TextEditingController();
  var countrydetails = Country().Countrydetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRate();
  }

  @override
  Widget build(BuildContext context) {
    List<String> country = Country().countryList;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 71, 71, 71),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 189, 189, 189)),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 189, 189, 189)),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: "Search Country",
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 189, 189, 189))),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: // Inside your build method, update the FutureBuilder:
                FutureBuilder(
              future: Country().getInfo(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData && snapshot.data is List) {
                  List<dynamic> data = snapshot.data;

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      if (index >= 0 && index < data.length) {
                        String tmpName = data[index]["name"]["common"]
                            .toString()
                            .toLowerCase();

                        if (searchController.text.isEmpty ||
                            tmpName.contains(
                                searchController.text.toLowerCase())) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Card(
                                  child: ListTile(
                                    leading: Image.network(
                                      data[index]["flags"]["png"],
                                      height: 35,
                                      width: 35,
                                    ),
                                    title: Text(data[index]["name"]["common"]),
                                    subtitle: Text("Currency: " +
                                        data[index]["currencies"]
                                            .toString()
                                            .substring(1, 4)),
                                    trailing: Text(data2["rates"][data[index]
                                                ["currencies"]
                                            .toString()
                                            .substring(1, 4)]
                                        .toString()),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Container(); // Return a placeholder if the index is out of range
                      }
                    },
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Color(0xff7d5fff),
                  ));
                }
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                      color: const Color(0xff7d5fff),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                      child: Text(
                    "Back",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          )
        ],
      )),
    );
  }
}
