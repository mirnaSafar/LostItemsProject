import 'package:flutter/material.dart';
import 'package:project1/pages/confirmItems_list.dart';
import 'package:project1/pages/confirm_back.dart';
import 'package:project1/pages/confirm.dart';
import '../widgets/bottombar.dart';
import '../widgets/drawer.dart';

import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class MessagesPage extends StatefulWidget {
  final int thingIndex;
  MessagesPage(this.thingIndex);
  State<StatefulWidget> createState() {
    return MessagesPageState();
  }
}

class MessagesPageState extends State<MessagesPage> {
  int _selectedindex = 0;
  void _navigator(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: buildDrawer(context),
          appBar: AppBar(
            title: Center(
              child: Text('Messages'),
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.message),
                  text: 'Send Message',
                ),
                Tab(
                  icon: Icon(Icons.mark_email_unread_rounded),
                  text: 'Your Mail',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              widget.thingIndex == null
                  ? Container(
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, 'home');
                          },
                          child: Text(
                              "Please pick a post to send confirm request")),
                    )
                  : ConfirmItem(widget.thingIndex),
              ScopedModelDescendant<MainModel>(builder:
                  (BuildContext context, Widget child, MainModel model) {
                if (widget.thingIndex != null)
                  model.selectThing(widget.thingIndex);
                return model.displayConfirmedItems.length == 0
                    ? Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.symmetric(vertical: 300.0),
                        child: Text("No Confirm Requests Yet"),
                      )
                    : ConfirmItemList(widget.thingIndex);
              })
            ],
          ),
          bottomNavigationBar: buildBottomNavigator(context, _selectedindex),
        ));
  }
}
