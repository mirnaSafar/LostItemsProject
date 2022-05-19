// import 'dart:html';

import 'package:flutter/material.dart';

_showDialogAlert(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure ?'),
          content: Text('you will logout from your account'),
          actions: [
            FlatButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text('DISCARD')),
            FlatButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text('CONTINUE'))
          ],
        );
      });
}

Widget buildProfileDrawer(BuildContext context) {
  return Drawer(
    child: Column(children: [
      AppBar(
        automaticallyImplyLeading: false,
        title: Text('Account'),
        actions: [Center(child: Icon(Icons.build_sharp))],
      ),
      ListTile(
        leading: Icon(Icons.account_circle),
        title: Text('Settings'),
        onTap: () {
          Navigator.pushNamed(context, '/account');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.add),
        title: Text('Manage Items'),
        onTap: () {
          Navigator.pushNamed(context, '/add');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () {
          Navigator.pushNamed(context, '/home');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text('LogOut'),
        onTap: () => _showDialogAlert(context),
      ),
      Divider(),
    ]),
  );
}
