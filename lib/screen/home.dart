import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inso_cur/components/inputField.dart';
import 'package:inso_cur/components/roundButton.dart';
import 'package:inso_cur/routs/routename.dart';
import 'package:inso_cur/screen/country_currency.dart';
import 'package:inso_cur/service/calculations/calculation.dart';
import 'package:inso_cur/service/country.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  var amountControl = TextEditingController();
  String dropDonwnvalue = Country().countryList[0];
  String dropDonwnvalue2 = Country().countryList[0];
  String? finalresult;
  bool clicked = false;
  var tempcntrl = TextEditingController();
  var tempcntrl2 = TextEditingController();
  var auth = FirebaseAuth.instance;
  String? name;
  String? email;
  var image;
  void getInfo() async {
    var user = await FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user)
        .get()
        .then((value) {
      setState(() {
        name = value.data()!["name"];
        email = value.data()!["email"];
        image = value.data()!["image"];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  String? changedamount;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * .1;
    var width = MediaQuery.of(context).size.width * .1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 30,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                padding: const EdgeInsets.symmetric(vertical: 39),
                decoration: const BoxDecoration(color: Color(0xff7d5fff)),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    backgroundImage: image == null
                        ? const AssetImage("assets/images/human.jpg")
                        : NetworkImage(
                            image,
                            scale: 10,
                          ) as ImageProvider,
                  ),
                  title: Text(
                    "${name ?? 'N/A'}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${email ?? 'N/A'}",
                    style: const TextStyle(fontSize: 14),
                  ),
                )),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteName.profilescreen);
              },
              leading: Icon(Icons.person),
              title: Text("Profile"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CountryDetailsList()));
              },
              leading: const Icon(Icons.webhook_outlined),
              title: const Text("All currency"),
            ),
            SizedBox(
              height: height * 4.3,
            ),
            ListTile(
              onTap: () {
                auth.signOut().then((value) {
                  Navigator.pushNamed(context, RouteName.loginScreen);
                });
              },
              leading: const Icon(Icons.logout),
              title: const Text("Log Out"),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 80,
                child: Image.asset("assets/images/inso_curr(logo).png"),
              ),
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                "to Money Exchnage",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),

              SizedBox(
                height: height * .2,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: inputField(
                        keyboard: TextInputType.number,
                        icons: Icons.attach_money_outlined,
                        hint: "amount",
                        fieldController: amountControl,
                        validator: (_) {}),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<dynamic>(
                        customButton: Container(
                          height: 63,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 71, 71, 71),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 189, 189, 189)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    dropDonwnvalue,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                Icon(Icons.place)
                              ],
                            ),
                          ),
                        ),
                        isExpanded: true,
                        hint: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: Country().countryList.map<DropdownMenuItem>((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        value: dropDonwnvalue,

                        onChanged: (value) {
                          setState(() {
                            dropDonwnvalue = value.toString();
                          });
                        },

                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 400,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: tempcntrl,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: tempcntrl,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return item.value
                                .toString()
                                .toLowerCase()
                                .contains(searchValue);
                          },
                        ),
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            tempcntrl.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .2,
              ),
              const Text("Which currency you want to exchange? "),
              SizedBox(
                height: height * .2,
              ),
              //test dropdown button

              DropdownButtonHideUnderline(
                child: DropdownButton2<dynamic>(
                  customButton: Container(
                    height: 63,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 71, 71, 71),
                        border: Border.all(
                            color: const Color.fromARGB(255, 189, 189, 189)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              dropDonwnvalue2,
                              style: const TextStyle(
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Icon(Icons.place)
                        ],
                      ),
                    ),
                  ),
                  isExpanded: true,
                  hint: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: Country().countryList.map<DropdownMenuItem>((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  value: dropDonwnvalue2,

                  onChanged: (value) {
                    setState(() {
                      dropDonwnvalue2 = value.toString();
                    });
                  },

                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 200,
                  ),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 400,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                  dropdownSearchData: DropdownSearchData(
                    searchController: tempcntrl2,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: Container(
                      height: 50,
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        controller: tempcntrl2,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Search for an item...',
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return item.value
                          .toString()
                          .toLowerCase()
                          .contains(searchValue);
                    },
                  ),
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      tempcntrl2.clear();
                    }
                  },
                ),
              ),

              SizedBox(
                height: height * .4,
              ),
              ChangeNotifierProvider(
                create: (_) => calculation(),
                child:
                    Consumer<calculation>(builder: (context, provider, child) {
                  return Column(
                    children: [
                      roundButton(
                          title: "Convert",
                          ontap: () {
                            provider
                                .calculations(
                                    amountControl.text,
                                    dropDonwnvalue.toString(),
                                    dropDonwnvalue2.toString())
                                .then((value) {
                              setState(() {
                                finalresult = provider.result.toString();
                              });
                            });
                          }),
                      SizedBox(
                        height: height * .3,
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 71, 71, 71),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 189, 189, 189)),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 6),
                              child: provider.result == null
                                  ? const Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          provider.result.toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              provider.changedCurrency
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontStyle: FontStyle.italic),
                                            ))
                                      ],
                                    )),
                        ),
                      ),
                    ],
                  );
                }),
              ),

              SizedBox(
                height: height * .5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 100,
                    //height: height * .9,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("Created By Shafin")),
                ],
              )
            ],
          ),
        )),
      )),
    );
  }
}
