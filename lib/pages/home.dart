import 'package:flutter/material.dart';

import '../scoped_model/main.dart';
import '../scoped_model/things.dart';

import 'package:scoped_model/scoped_model.dart';
import '../widgets/bottombar.dart';
import '../widgets/drawer.dart';
import '../widgets/items/items.dart';
import '../models/thing.dart';
import 'confirm.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedindex = 1;

  void _navigator(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = "Home Page";
    return DefaultTabController(
        length: 2,
        child: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return Scaffold(
              drawer: buildDrawer(context),
              appBar: AppBar(
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      model.displayFavoritesOnly
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      model.toggleDisplayMode();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      // model.displayLostOnly
                      Icons.search_off,
                      // : Icons.search_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      model.toggleStatusDisplayMode(1);
                      title = "Lost";
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      model.toggleStatusDisplayMode(0);
                      title = "Found";
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.all_inbox,
                    ),
                    onPressed: () {
                      model.toggleStatusDisplayMode(-1);
                      title = "Home Page";
                    },
                  ),
                ],
                brightness: Brightness.dark,
                title: Container(
                  child: Text(title),
                ),
              ),
              body: Container(child: Items()),
              bottomNavigationBar:
                  buildBottomNavigator(context, _selectedindex));
        }));
  }
}
