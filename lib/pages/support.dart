import 'package:flutter/material.dart';
import 'package:project1/pages/confirm.dart';

import 'package:project1/pages/confirm_back.dart';
import 'package:project1/pages/myConfirm_request.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

// import '../models/thing.dart';
class SupportPage extends StatelessWidget {
  final String money;
  final String desc;
  final int index;

  SupportPage(this.desc, this.money, this.index);
  Widget _buildConfirmRequestButton(
      BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.confirmation_num_outlined),
      onPressed: () {
        model.selectThing(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MyConfirmRequest(desc, money, index);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('My Request confirm Items'),
          ),
        ),
        body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return model.allThings.length == 0
                    ? Container()
                    : Container(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    model.displayConfirmedItems[index].image),
                              ),
                              title: Text(
                                  model.displayConfirmedItems[index].title),
                              subtitle: Text(
                                  '${model.displayConfirmedItems[index].status}'),
                              trailing: _buildConfirmRequestButton(
                                  context, index, model),
                            ),
                            Divider()
                          ],
                        ),
                      );
              },
              itemCount: model.displayConfirmedItems.length,
            );
          },
        ));
    // ListView(
    //   children: <Widget>[
    //     ScopedModelDescendant<MainModel>(
    //         builder: (BuildContext context, Widget child, MainModel model) {
    //       return ListTile(
    //         leading: CircleAvatar(
    //           backgroundImage: AssetImage('assets/food.jpg'),
    //         ),
    //         title: Text(model.allThings[index].userName),
    //         subtitle: Text('money? ${money}\n' + desc),
    //         trailing: _buildConfirmRequestButton(context),
    //       );
    //     }),
    //     Divider()
    //   ],
    // )
    // );
  }
  // itemCount: model.allThings.length,

}
