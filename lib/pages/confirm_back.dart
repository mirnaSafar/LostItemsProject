// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:project1/pages/confirm.dart';
import 'package:project1/pages/messages.dart';
import 'package:project1/pages/support.dart';
import '../widgets/items/userName_tag.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ConfirmBack extends StatelessWidget {
  final String money;
  final String desc;
  final int index;
  bool _response;
  ConfirmBack(this.desc, this.money, this.index);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('confirm item'),
          ),
        ),
        body: Form(
            // padding: EdgeInsets.all(5.0),
            key: _key,
            child: ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
              return ListView(
                padding: EdgeInsets.all(10.0),
                children: [
                  //
                  Card(
                    child: Column(
                      children: <Widget>[
                        UserNameTag(model.allThings[index].userName),
                        Image.asset(model.allThings[index].image),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(money),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            desc,
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  ButtonBar(
                    buttonMinWidth: 120.0,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          model.toggleResponse(true);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return SupportPage(desc, money, index);
                          }));
                          // .then((_) => model.toggleResponse(null));
                        },
                        child: Text("yes, that is it"),
                        color: Colors.blue[50],
                      ),
                      RaisedButton(
                        color: Colors.blue[50],
                        onPressed: () {
                          model.toggleResponse(false);

                          _key.currentState.save();

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return SupportPage(desc, money, index);
                          }));
                          // then((_) => model.toggleResponse(null));
                          // model.toggleResponse(null);
                          // SupportPage(desc, money, index);
                        },
                        child: Text("no, that's not it"),
                      ),
                    ],
                  ),
                ],
              );
            })));
  }
}
