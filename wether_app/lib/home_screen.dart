import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:wether_app/constants.dart' as k;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = false;
  num temb = 0;
  num hum = 0;
  num press = 0;
  num cover = 0;
  TextEditingController controller = TextEditingController();
  String cityname = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding:const EdgeInsets.all(20),
          decoration:const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xffFA88FF),
            Color(0xff28D2FF),
            Color(0xff2BFF88),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
          child: Visibility(
            visible: isLoaded,
            replacement:const Center(child: CircularProgressIndicator()),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.07,
                  padding:const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius:const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: TextFormField(
                      onFieldSubmitted: (String s) {
                        setState(() {
                          cityname = s;
                          getCityWether(cityname);
                          isLoaded = false;
                        });
                      },
                      controller: controller,
                      style:const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Search City",
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            size: 25,
                            color: Colors.white.withOpacity(0.7),
                          )),
                    ),
                  ),
                ),
              const  SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                    const  Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                        size: 40,
                      ),
                      Text(
                        cityname,
                        style:const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              const  SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.400,
                      height: MediaQuery.of(context).size.height * 0.13,
                      decoration:const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 219, 47, 113),
                                Color(0xff28D2FF),
                                Color(0xff2BFF88),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: Text(
                          'temprature:${temb.toStringAsFixed(2)}',
                          style:const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.400,
                      height: MediaQuery.of(context).size.height * 0.13,
                      decoration:const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 219, 47, 113),
                                Color(0xff28D2FF),
                                Color(0xff2BFF88),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: Text(
                          'humidity:${hum.toStringAsFixed(2)}',
                          style:const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
               const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.400,
                      height: MediaQuery.of(context).size.height * 0.13,
                      decoration:const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 219, 47, 113),
                                Color(0xff28D2FF),
                                Color(0xff2BFF88),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: Text(
                          'Clouds:${cover.toStringAsFixed(2)}',
                          style:const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.400,
                      height: MediaQuery.of(context).size.height * 0.13,
                      decoration:const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 219, 47, 113),
                                Color(0xff28D2FF),
                                Color(0xff2BFF88),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: Text(
                          'Prussure:${press.toStringAsFixed(2)}',
                          style:const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getCurrentLocation() async {
    var p = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        forceAndroidLocationManager: true);
    if (p != null) {
      getCurrentCityWether(p);
      print("Lat:${p.latitude}" "Long${p.longitude}");
    } else {
      print("Data Unavalable");
    }
  }

  getCurrentCityWether(Position position) async {
    var client = http.Client();
    var uri =
        '${k.baseurl}lat=${position.latitude}&lon=${position.longitude}&appid=1a01e2339e0fee4d3e930864d1a76466';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedDat = json.decode(data);
      print(data);
      updateUi(decodedDat);
      setState(() {
        isLoaded = true;
      });
    } else {
      print(response.statusCode);
    }
  }

  updateUi(var decodedData) {
    setState(() {
      if (decodedData == null) {
        cityname = "not Avalable";
      } else {
        temb = decodedData['main']['temp_min'] - 273;
        hum = decodedData['main']['humidity'];
        press = decodedData['main']['pressure'];
        cover = decodedData['clouds']['all'];
        cityname = decodedData['name'];
      }
    });
  }

  getCityWether(String cityname) async {
    var client = http.Client();
    var uri = '${k.baseurl}q=$cityname&appid=1a01e2339e0fee4d3e930864d1a76466';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedDat = json.decode(data);
      print(data);
      updateUi(decodedDat);
      setState(() {
        isLoaded = true;
      });
    } else {
      print(response.statusCode);
    }
  }
}


//1a01e2339e0fee4d3e930864d1a76466