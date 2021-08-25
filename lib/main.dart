
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'about.dart';

void main() => runApp(new MaterialApp( debugShowCheckedModeBanner: false, home: new Main()));

// ignore: must_be_immutable
class Main extends StatelessWidget {
  late var x,
      x1,
      x2,
      x3,
      x4,
      x5,
      x6,
      x7;

//METHOD TO PREDICT PRICE
  // ignore: non_constant_identifier_names
  Future<String?> Diabetespredictor(var body) async {
    var client = new http.Client();
    var uri = Uri.parse("http://192.168.99.100:30370/result");
    Map<String, String> headers = {"Accept": "application/json", "Access-Control-Allow-Orgin" : "*", "Access-Control-Allow-Methods":"POST", "Access-Control-Allow-Headers":"*" };
    String jsonString = json.encode(body);
    try {
      var resp = await client.post(uri, headers: headers, body: jsonString);
      if (resp.statusCode == 200) {
        print("DATA FETCHED SUCCESSFULLY");
        var result = json.decode(resp.body);
        print(result);
        return result['prediction'];
      }
    } catch (e) {
      print("EXCEPTION OCCURRED: $e");
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,leading: CircleAvatar(
          backgroundColor: Colors.greenAccent, child: IconButton(
            alignment: Alignment.topLeft, onPressed: ()=>showDialog(
              context: context, builder: (BuildContext context) => SimpleDialog(
                backgroundColor: Colors.white, title: Text("Diabetes Predictor", 
                style: TextStyle(letterSpacing: 1.0, fontWeight: FontWeight.bold, fontSize: 26.0, fontFamily: "courier new",
                ),
                ),
                children: [
                  Column(
                    children: [
                      Card(
                        color: Colors.white, shadowColor: Colors.grey, borderOnForeground: true, child: ListTile(
                          trailing: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => About(), 
                          ),
                           ),
                           icon: Icon(Icons.apps_rounded),
                           ),
                           title: Text(
                             "About App",
                             style: TextStyle(fontWeight: FontWeight.bold,
                             fontSize: 20.0, fontFamily: "courier new"),
                           ),
                        ),
                      )
                    ],
                  )
                ],
              )
              ), icon: Icon(
                Icons.contacts,
                color: Colors.white,size: 35.0,
              ),
              ),
              ),
              title: Center(
                child: Text("Diabetes Predictor",
              style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: "courier new", 
                fontSize: 35.0,
              ),
              ),
              ),
              ),
      body: Container( 
        margin: EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Number of times pregnant',
                  ),
                  keyboardType:TextInputType.numberWithOptions(decimal: true),
                  onChanged: (pg) {
                    x = double.parse(pg);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Plasma glucose concentration a 2 hours in an oral glucose tolerance test',
                  ),
                  keyboardType:TextInputType.numberWithOptions(decimal: true),
                  onChanged: (pgc) {
                    x1 = double.parse(pgc);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Diastolic blood pressure (mm Hg)',
                  ),
                  keyboardType:TextInputType.numberWithOptions(decimal: true),
                  onChanged: (dbp) { 
                    x2 = double.parse(dbp);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Triceps skin fold thickness (mm)',
                  ),
                  keyboardType:TextInputType.numberWithOptions(decimal: true),
                  onChanged: (tsft) {
                    x3 = double.parse(tsft);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: '2-Hour serum insulin (mu U/ml)',
                  ),
                  keyboardType:TextInputType.numberWithOptions(decimal: true),
                  onChanged: (sein) {
                    x4 = double.parse(sein);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Body mass index (weight in kg/(height in m)^2)',
                  ),
                  keyboardType:TextInputType.numberWithOptions(decimal: true),
                  onChanged: (bmi) {
                    x5 = double.parse(bmi);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Diabetes pedigree function',
                  ),
                  keyboardType:TextInputType.numberWithOptions(decimal: true),
                  onChanged: (dpf) {
                    x6 = double.parse(dpf);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Age (years)',
                  ),
                  keyboardType:TextInputType.numberWithOptions(decimal: true),
                  onChanged: (age) {
                    x7 = double.parse(age);
                  },
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    var body = [
                      {
                        "x": x,
                        "x1": x1,
                        "x2": x2,
                        "x3": x3,
                        "x4": x4,
                        "x5": x5,
                        "x6": x6,
                        "x7": x7,
                      }];
                    /*body=[
                    {"bedrooms": 3, "bathrooms": 1, "sqft_living": 1180, "sqft_lot": 5650, "floors": 1, "waterfront": 0, "view": 0, "condition": 3, "grade": 7, "sqft_above": 1180, "sqft_basement": 0, "lat": 47.5112, "long": -122.257, "sqft_living15": 1340, "sqft_lot15": 5650}
                  ];*/
                    print(body);
                    var resp = await Diabetespredictor(body);
                    _onBasicAlertPressed(context, resp);
                  },
                  child: Text("Get prediction"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//function from rflutter pkg to display alert
_onBasicAlertPressed(context, resp) {
  Alert(context: context, title: "Diabetes results", desc: resp).show();
}