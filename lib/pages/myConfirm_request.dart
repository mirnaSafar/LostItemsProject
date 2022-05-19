// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:project1/pages/confirm.dart';
import 'package:project1/pages/messages.dart';
import '../widgets/items/userName_tag.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class MyConfirmRequest extends StatelessWidget {
  final String money;
  final String desc;
  final int index;

  MyConfirmRequest(this.desc, this.money, this.index);
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
                  ScopedModelDescendant<MainModel>(builder:
                      (BuildContext context, Widget child, MainModel model) {
                    if (model.response == null) {
                      return Container();
                    }

                    if (model.response) {
                      return Container(
                        color: Colors.lightGreen,
                        padding: EdgeInsets.all(10.0),
                        child: Row(children: [
                          Icon(
                            Icons.circle_notifications,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            "the response: it's the same item ",
                            style: TextStyle(fontSize: 13.0, letterSpacing: 2),
                          ),
                        ]),
                      );
                    } else
                      return Container(
                          color: Colors.red,
                          padding: EdgeInsets.all(10.0),
                          child: Row(children: [
                            Icon(
                              Icons.circle_notifications,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "the response: it's not the same item ",
                              style:
                                  TextStyle(fontSize: 13.0, letterSpacing: 2),
                            ),
                          ]));

                    // model.response(null);
                  }),
                ],
              );
            })));
  }
}
