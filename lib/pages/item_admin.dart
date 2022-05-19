import 'package:flutter/material.dart';
import 'package:project1/pages/items.dart';
import 'package:project1/pages/thing_list.dart';

import 'add_page.dart';
import 'items.dart';
import '../widgets/drawer.dart';

class ThingsAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: buildDrawer(context),
        appBar: AppBar(
          title: Text('Manage Items'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Add Item',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My posts',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[AddPage(""), ItemsPage()],
        ),
      ),
    );
  }
}
