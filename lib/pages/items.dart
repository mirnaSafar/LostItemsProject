import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/items/items.dart';
import '../scoped_model/main.dart';
import '../widgets/drawer.dart';

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Text('Items'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          )
        ],
      ),
      body: Items(),
    ));
  }
}


  // Widget _buildItem(BuildContext context, int index) {
  //   return Column(
  //     children: [
  //       //ThingPage(),
  //       RaisedButton(
  //         onPressed: () {
  //           Navigator.of(context)
  //               .push(MaterialPageRoute(builder: (BuildContext context) {
  //             return MessagesPage();
  //           }));
  //         },
  //         child: Text('confirm'),
  //       )
  //     ],
  //   );

    // return Card(
    //   child: Column(
    //     children: <Widget>[
    //       Image.asset(items[index].image),
    //       Text(items[index].title),
    //       ButtonBar(
    //         alignment: MainAxisAlignment.center,
    //         children: [
    //           FlatButton(onPressed: itemDetail, child: Text('Details'))
    //         ],
    //       )
    //       //HomePage()
    //     ],
    //   ),
    // );
  
