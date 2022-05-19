import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'widgets/items/item_card.dart';
import 'models/thing.dart';
import 'scoped_model/main.dart';

class FoundItems extends StatelessWidget {
  Widget _buildthingList(List<Thing> things) {
    Widget thingCards;
    if (things.length > 0) {
      thingCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ThingCard(things[index], index),
        itemCount: things.length,
      );
    } else {
      thingCards =
          Center(child: Text('No posts for now, add what you lost or found'));
    }
    return thingCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[things Widget] build()');
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildthingList(model.displayedFoundStatusItems);
      },
    );
  }
}
