import 'package:flutter/material.dart';

import 'package:project1/pages/confirm_back.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';
// import '../models/thing.dart';

class ConfirmItemList extends StatelessWidget {
  final String money;
  final String desc;
  final int index;
  ConfirmItemList(this.desc, this.money, this.index);

  Widget _buildConfirmButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.circle_notifications),
      onPressed: () {
        model.selectThing(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ConfirmBack(desc, money, index);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return model.allThings.length == 0
                ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 300.0),
                    child: Text("No Confirm Requests Yet"),
                  )
                : Container(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                                model.displayConfirmedItems[index].image),
                          ),
                          title: Text(model.displayConfirmedItems[index].title),
                          subtitle: Text(
                              '${model.displayConfirmedItems[index].status}'),
                          trailing: _buildConfirmButton(context, index, model),
                        ),
                        Divider()
                      ],
                    ),
                  );
          },
          itemCount: model.displayConfirmedItems.length,
        );
      },
    );
  }
}
  // .builder(
  //     itemBuilder: (BuildContext context, int index) return ListView{
  //   // return ListView(
  //     children: <Widget>[
  //       ScopedModelDescendant<MainModel>(
  //           builder: (BuildContext context, Widget child, MainModel model) {
  //         return ListTile(
  //           leading: CircleAvatar(
  //             backgroundImage: AssetImage('assets/food.jpg'),
  //           ),
  //           title: Text('model.userName'),
  //           subtitle: Text('money? ${money}\n' + desc),
  //           trailing: _buildConfirmButton(context),
  //         );
  //       }),
  //       Divider()
  //     ],
  //   );
  // }
  // // itemCount: model.allThings.length,


