import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Covid pandemic'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String valueChoose = "Viet Nam";
  List listItem = ["Viet Nam", "World"];
  String totalCases = "";
  String newCases = "";
  String totalDeaths = "";
  String newDeaths = "";
  String totalRecoveries = "";
  String newRecoveries = "";
  String totalInjections = "";
  String newInjections = "";

  void GetData() async
  {
    Response response = await get(Uri.parse("https://covidpandemic.herokuapp.com/api?nation=${valueChoose}"));
    Map data = jsonDecode(response.body);
    setState(() {
      totalCases = "Tong so ca nhiem: ${data['total_cases']}";
      newCases = "Ca nhiem moi hom nay: ${data['new_cases']}";
      totalDeaths = "Tong so ca tu vong: ${data['total_deaths']}";
      newDeaths = "Ca tu vong hom nay: ${data['new_deaths']}";
      totalRecoveries = "Tong so ca phuc hoi: ${data['total_recoveries']}";
      newRecoveries = "Ca phuc hoi hom nay: ${data['new_recoveries']}";
      totalInjections = "Tong so mui da tiem: ${data['total_injections']}";
      newInjections = "So mui tiem hom nay: ${data['new_injections']}";
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "SỐ LIỆU COVID-19",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton(
                      hint: Text(valueChoose),
                      dropdownColor: Colors.grey[100],
                      underline: SizedBox(),
                      value: valueChoose,
                      onChanged: (newValue)
                      {
                        setState(() {
                          valueChoose = newValue.toString();
                        });
                      },
                      items: listItem.map((valueItem)
                      {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      GetData();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
                    color: Colors.lightBlueAccent[200],
                    child: Text("Xem", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Text(totalCases, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
              SizedBox(height: 14,),
              Text(newCases, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
              SizedBox(height: 14,),
              Text(totalDeaths, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
              SizedBox(height: 14,),
              Text(newDeaths, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
              SizedBox(height: 14,),
              Text(totalRecoveries, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
              SizedBox(height: 14,),
              Text(newRecoveries, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
              SizedBox(height: 14,),
              Text(totalInjections, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
              SizedBox(height: 14,),
              Text(newInjections, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
            ],
          ),
        ),
      ),
    );
  }
}
