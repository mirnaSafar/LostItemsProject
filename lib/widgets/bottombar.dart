import 'package:flutter/material.dart';

void _navigator(int index) {}

BottomNavigationBar buildBottomNavigator(
    BuildContext context, int _selectedindex) {
  return BottomNavigationBar(
    selectedItemColor: Theme.of(context).buttonColor,
    unselectedItemColor: Colors.black,
    currentIndex: _selectedindex,
    selectedFontSize: 15,
    type: BottomNavigationBarType.shifting,
    onTap: _navigator,
    items: [
      BottomNavigationBarItem(
        icon: IconButton(
          icon: Icon(Icons.mail),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/messages');
          },
        ),
        title: Text('notification'),
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: Text('home'),
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: Icon(Icons.add_box),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/add');
          },
        ),
        title: Text('add'),
      )
    ],
  );
}
