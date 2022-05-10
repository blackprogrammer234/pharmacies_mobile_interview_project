import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import '../../model/pharmacies.dart';
import 'package:flutter/services.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pharmacies"),
        ),
        body: Container(
          child: FutureBuilder(
            future: readPharmaciesJsonData(),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Center(child: Text("${snapshot.error}"),);
              }else if(snapshot.hasData){
                var data = snapshot.data as List<PharmaciesModel>;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Card(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 32.0, bottom: 32.0, left: 16, right: 16),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(data[index].pharmacy_name.toString(),
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold)),
                                      Text(data[index].pharmacy_id.toString())
                                    ])),
                            elevation: 8,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white))));
                  },
                  itemCount: data == null ? 0 : data.length,
                );
              }
              else{
                return Center(child: CircularProgressIndicator(),);
              }
              var data = json.decode(snapshot.data.toString());
            },
          ),
        ),
      ),
    );
  }

  Future<List<PharmaciesModel>>readPharmaciesJsonData() async{
    var jsonData = await rootBundle.loadString("assets/pharmacies_data");
    Map<String, dynamic> list = json.decode(jsonData);
    List<dynamic> data = list["pharmacies"];
    return data.map((e) => PharmaciesModel.fromJson(e)).toList();
  }
}
