// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:project1/pages/auth_page.dart';

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
                onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return AuthPage();
                      }))
                    },
                child: Text('CONTINUE'))
          ],
        );
      });
}

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: Column(children: [
      AppBar(
        automaticallyImplyLeading: false,
        title: Text('Options'),
        actions: [Center(child: Icon(Icons.build_sharp))],
      ),
      ListTile(
        leading: Icon(Icons.account_circle),
        title: Text('My Profile'),
        onTap: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.add),
        title: Text('Post What you Lost or Found'),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/add');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.question_answer),
        title: Text('Confirm requests'),
        onTap: () {
          Navigator.pushNamed(context, '/myConfirms');
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
