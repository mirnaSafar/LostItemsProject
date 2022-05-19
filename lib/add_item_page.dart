import 'package:flutter/material.dart';
import 'package:project1/models/thing.dart';
//import 'package:map_view/map_view.dart';
import 'widgets/image.dart';
import 'widgets/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';

class AddItemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddItemPageState();
  }
}

class AddItemPageState extends State<AddItemPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Find Your Lost Stuff"),
            ),
            body: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: Column(children: [
                  // RaisedButton(
                  //   onPressed: () {},
                  //   child: Text('add what you lost'),
                  // ),
                  SizedBox(height: 10.0),
                  // ImageInput(Thing thing),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "Locate where you found or lost it")),
                  // LocationInput(),
                  SizedBox(height: 10.0),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "Input the time when you found/lost it")),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "put a number to contact")),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    onPressed: () {},
                    child: Text("Post"),
                  )
                ]))));
  }
}
