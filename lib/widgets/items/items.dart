import 'package:flutter/material.dart';
import 'package:project1/found_thing_page.dart';
import 'package:project1/missing_page.dart';

import 'package:scoped_model/scoped_model.dart';

import './item_card.dart';
import '../../models/thing.dart';
import '../../scoped_model/main.dart';

class Items extends StatelessWidget {
  int s;
  Widget _buildthingList(List<Thing> things) {
    Widget thingCards;
    if (things.length > 0) {
      thingCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ThingCard(things[index], index),
        itemCount: things.length,
      );
    } else {
      thingCards = Center(
          child: Text('No posts for now, add what you lost or found $s'));
    }
    return thingCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[things Widget] build()');
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        s = model.allThings.length;
        // if (model.displayLostOnly == 1 && model.allThings.length > 0)
        //   return LostItems();
        // else if (model.displayLostOnly == 0 && model.allThings.length > 0)
        //   return FoundItems();
        return _buildthingList(
            // model.displayLostOnly == 1
            // ? model.displayedLostStatusItems
            // : model.displayLostOnly == 0
            //     ? model.displayedFoundStatusItems:
            model.displayedThings);
      },
    );
  }
}
