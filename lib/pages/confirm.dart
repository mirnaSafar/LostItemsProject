import 'package:flutter/material.dart';
import 'package:project1/pages/confirmItems_list.dart';

import 'package:project1/pages/support.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/image.dart';
import '../models/thing.dart';
import '../scoped_model/main.dart';

class ConfirmItem extends StatefulWidget {
  final int thingIndex;

  ConfirmItem(this.thingIndex);
  @override
  State<StatefulWidget> createState() {
    return ConfirmItemState();
  }
}

class ConfirmItemState extends State<ConfirmItem> {
  bool _response = false;

  Map<String, dynamic> _confirmData = {
    'money': "",
    'desc': "",
  };

  final GlobalKey<FormState> _confirmkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(60.0),
        child: Form(
          key: _confirmkey,
          child: ListView(
            children: [
              ImageInput(),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'if it is money , how much?'),
                onSaved: (String value) {
                  _confirmData['money'] = value;
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'some details you want to add?'),
                onSaved: (String value) {
                  _confirmData['desc'] = value;
                  Text(value);
                },
                maxLines: 2,
              ),
              // Text(_confirmData['desc']),
              SizedBox(
                height: 20.0,
              ),
              ScopedModelDescendant<MainModel>(builder:
                  (BuildContext context, Widget child, MainModel model) {
                model.selectThing(widget.thingIndex);
                return model.selectedthing.confirmed
                    ? Text(
                        'Sent Successfully!',
                        textAlign: TextAlign.center,
                      )
                    : FlatButton(
                        onPressed: () {
                          _confirmkey.currentState.save();

                          model.selectThing(widget.thingIndex);
                          model.toggleThingConfirmStatus();
                          print(model.displayConfirmedItems.length.toString());
                          // ignore: unnecessary_statements
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) {
                          //   return ConfirmItemList(_confirmData['desc'],
                          //       _confirmData['money'], widget.thingIndex);
                          // })).then((_) => model.selectThing(null));
                        },
                        child: Text('send'),
                      );
              }),
              // ScopedModelDescendant<MainModel>(builder:
              //     (BuildContext context, Widget child, MainModel model) {
              //   if (model.response == null) {
              //     return Container();
              //   }

              //   if (model.response) {
              //     return Container(
              //         color: Colors.lightGreen,
              //         padding: EdgeInsets.all(10.0),
              //         child: Row(children: [
              //           Icon(
              //             Icons.circle_notifications,
              //             color: Colors.white,
              //           ),
              //           SizedBox(
              //             width: 4.0,
              //           ),
              //           Text(
              //             "the response: it's the same item ",
              //             style: TextStyle(fontSize: 13.0, letterSpacing: 2),
              //           ),
              //         ]));
              //   } else
              //     return Container(
              //         color: Colors.red,
              //         padding: EdgeInsets.all(10.0),
              //         child: Row(children: [
              //           Icon(
              //             Icons.circle_notifications,
              //             color: Colors.white,
              //           ),
              //           SizedBox(
              //             width: 4.0,
              //           ),
              //           Text(
              //             "the response: it's not the same item ",
              //             style: TextStyle(fontSize: 13.0, letterSpacing: 2),
              //           )
              //         ]));
              // }),
            ],
          ),
        ));
  }
}
