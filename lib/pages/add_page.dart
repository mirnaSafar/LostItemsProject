import 'package:flutter/material.dart';
import 'package:project1/pages/items.dart';
import 'package:project1/pages/thing_list.dart';

import '../widgets/bottombar.dart';

import '../widgets/image.dart';
import '../widgets/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';
import '../scoped_model/things.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/thing.dart';
import '../scoped_model/main.dart';
import '../found_thing_page.dart';
import '../widgets/helpers/13.1 ensure_visible.dart.dart';

class AddPage extends StatefulWidget {
  final String image;
  AddPage(this.image);
  @override
  State<StatefulWidget> createState() {
    return AddPageState();
  }
}

class AddPageState extends State<AddPage> {
  int _selectedindex = 2;
  final Map<String, dynamic> _formData = {
    'title': "",
    'description': "",
    'status': "lost",
    'image': "",
    'date': DateTime.now(),
    'location': "d",
    // 'userEmail': "d",
    // 'userId': "d",
    'number': "",
    'time': ""
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _statusFocusNode = FocusNode();
  // final _passFocusNode = FocusNode();
  // final _emailFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _dateFocusNode = FocusNode();
  final _timeFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  final _nameTextController = TextEditingController();
  final _descTextController = TextEditingController();

  void _navigator(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  Widget _buildNameTextField(Thing thing) {
    if (thing == null && _nameTextController.text.trim() == '')
      _nameTextController.text = '';
    else if (thing != null && _nameTextController.text.trim() == '')
      _nameTextController.text = thing.title;
    else if (_nameTextController.text.trim() != '')
      _nameTextController.text = _nameTextController.text;
    else
      _nameTextController.text = '';

    return EnsureVisibleWhenFocused(
      focusNode: _nameFocusNode,
      child: TextFormField(
        controller: _nameTextController,
        focusNode: _nameFocusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Item type is:',
          labelStyle: TextStyle(color: Colors.grey),
        ),
        //enabledBorder: OutlineInputBorder()),
        //  keyboardType: TextInputType.text,

        //autovalidate: true,

        validator: (String value) {
          if (value.isEmpty) {
            return 'item name is required';
          }
        },
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildStatusTextField(Thing thing) {
    return EnsureVisibleWhenFocused(
      focusNode: _statusFocusNode,
      child: TextFormField(
        focusNode: _statusFocusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'found/lost:',
          labelStyle: TextStyle(color: Colors.grey),
        ),
        initialValue: thing == null ? '' : thing.status,
        validator: (String value) {
          if (value.isEmpty || (value != 'found' && value != 'lost')) {
            return 'found or lost?';
          }
        },
        onSaved: (String value) {
          _formData['status'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(Thing thing) {
    if (thing == null && _descTextController.text.trim() == '')
      _descTextController.text = '';
    else if (thing != null && _descTextController.text.trim() == '')
      _descTextController.text = thing.description;

    return EnsureVisibleWhenFocused(
        focusNode: _descFocusNode,
        child: TextFormField(
          controller: _descTextController,
          focusNode: _descFocusNode,
          maxLines: 2,
          decoration: InputDecoration(
            labelText:
                'description, is there any additional description you can add ?',
            labelStyle: TextStyle(color: Colors.grey),
          ),
          // autovalidate: true,
          validator: (String value) {
            if (value.isEmpty || value.length < 5) {
              return 'any detail may help';
            }
          },
          onSaved: (String value) {
            _formData['description'] = value;
          },
        ));
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
  }

  final _dateTextController = TextEditingController();
  Widget _buildDateTextField(Thing thing) {
    if (thing == null && _dateTextController.text.trim() == '')
      _dateTextController.text = '';
    else if (thing != null && _dateTextController.text.trim() == '')
      _dateTextController.text = thing.date;

    return EnsureVisibleWhenFocused(
        focusNode: _dateFocusNode,
        child: TextFormField(
          controller: _dateTextController,
          focusNode: _dateFocusNode,
          decoration: InputDecoration(
              filled: true,
              //  fillColor: Colors.amber[150],
              icon: Icon(
                Icons.date_range,
                color: Colors.blue,
              ),
              labelText: 'Set The date',
              labelStyle: TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).accentColor, width: 3),
              )),
          keyboardType: TextInputType.datetime,
          onTap: () => _showDatePicker(context),
          onSaved: (String value) {
            _formData['date'] = value;
          },
        ));
  }

  final _phoneTextController = TextEditingController();
  Widget _buildPhoneNumberTextField(Thing thing) {
    if (thing == null && _phoneTextController.text.trim() == '')
      _phoneTextController.text = '';
    else if (thing != null && _phoneTextController.text.trim() == '')
      _phoneTextController.text = thing.number;

    return EnsureVisibleWhenFocused(
        focusNode: _phoneFocusNode,
        child: TextFormField(
          focusNode: _phoneFocusNode,
          controller: _phoneTextController,
          decoration: InputDecoration(
              filled: true,
              // fillColor: Theme.of(context).accentColor,
              icon: Icon(
                Icons.phone,
                color: Colors.amberAccent,
              ),
              labelText: 'Enter number to contact',
              labelStyle: TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).accentColor, width: 3),
              )),
          keyboardType: TextInputType.text,
          onSaved: (String value) {
            _formData['number'] = value;
          },
        ));
  }

  final _timeTextController = TextEditingController();
  Widget _buildTimeTextField(Thing thing) {
    if (thing == null && _timeTextController.text.trim() == '')
      _timeTextController.text = '';
    else if (thing != null && _timeTextController.text.trim() == '')
      _timeTextController.text = thing.time;

    return EnsureVisibleWhenFocused(
        focusNode: _timeFocusNode,
        child: TextFormField(
          focusNode: _timeFocusNode,
          controller: _timeTextController,
          decoration: InputDecoration(
            // filled: true,
            // fillColor: Colors.amber[150],
            labelText: 'Set relative time',
            labelStyle: TextStyle(color: Colors.grey),
            // enabledBorder: OutlineInputBorder(
            //     borderSide: BorderSide(color: Colors.blue, width: 3))
          ),
          keyboardType: TextInputType.datetime,
          onSaved: (String value) {
            _formData['time'] = value;
          },
        ));
  }

  final _locationTextController = TextEditingController();
  Widget _buildLocationTextField(Thing thing) {
    if (thing == null && _locationTextController.text.trim() == '')
      _locationTextController.text = '';
    else if (thing != null && _locationTextController.text.trim() == '')
      _locationTextController.text = thing.location;

    return EnsureVisibleWhenFocused(
        focusNode: _locationFocusNode,
        child: TextFormField(
          controller: _locationTextController,
          focusNode: _locationFocusNode,
          decoration: InputDecoration(
              // filled: true,
              // fillColor: Theme.of(context).accentColor,
              labelText: 'Set the location',
              labelStyle: TextStyle(color: Colors.grey),
              icon: Icon(
                Icons.location_on,
                color: Colors.amberAccent,
              )),
          // autovalidate: true,
          validator: (String value) {
            if (value.isEmpty) {
              return '*Required ';
            }
          },
          onSaved: (String value) {
            _formData['location'] = value;
          },
        ));
  }

  void _submitForm(
      Function addThing, Function updateThing, Function setSelectedThing,
      [int selectedThingIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    // _showAlertDialog(context);
    _formData['image'] = widget.image;
    if (selectedThingIndex == null) {
      addThing(
          _nameTextController.text,
          _descTextController.text,
          _dateTextController.text,
          _phoneTextController.text,
          _locationTextController.text,
          _timeTextController.text,
          // _nameTextController.text,
          _formData['image'],
          _formData['status']);
      // if (_formData['status'] == 'found') {
      //   model.toggleStatusDisplayMode(true);
      // } else {
      //   model.toggleStatusDisplayMode(false);
      // }

      Navigator.pushReplacementNamed(context, '/home').then((_) => {
            setSelectedThing(null),
          });
      //   Navigator.pushNamed(context, '/found')
      //       .then((_) => setSelectedThing(null));
      // else
      //   Navigator.pushNamed(context, '/missing')
      //       .then((_) => setSelectedThing(null));
    } else {
      updateThing(
          _nameTextController.text,
          _descTextController.text,
          _formData['date'],
          _formData['number'],
          _formData['location'],
          _formData['time'],
          _formData['image'],
          _formData['status']);
    }
    // if (_formData['status'] == 'found')
    //   Navigator.pushNamed(context, '/items')
    //       .then((_) => setSelectedThing(null));
    // else
    Navigator.pushNamed(context, '/home').then((_) => setSelectedThing(null));
  }

  // _showAlertDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Did you lost this Item or Found it ?'),
  //           actions: [
  //             FlatButton(
  //                 onPressed: () =>
  //                     {Navigator.pushReplacementNamed(context, '/items')},
  //                 child: Text('Lost it')),
  //             FlatButton(
  //                 onPressed: () =>
  //                     {Navigator.pushReplacementNamed(context, '/items')},
  //                 child: Text(' Found It '))
  //           ],
  //         );
  //       });
  // }

  Widget _addItem(BuildContext context, Thing thing) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Form(
              key: _formKey,
              child: ListView(padding: EdgeInsets.all(10.0), children: [
                ImageInput(),
                SizedBox(
                  height: 10.0,
                ),
                // _buildEmailTextField(context),
                // SizedBox(height: 20.5),

                _buildTimeTextField(thing),
                SizedBox(height: 20.5),
                _buildStatusTextField(thing),
                _buildDescriptionTextField(thing),
                _buildNameTextField(thing),
                // _buildLocationTextField(thing),
                // LocationInput(),
                _buildLocationTextField(thing),
                SizedBox(height: 10.0),

                _buildDateTextField(thing),
                SizedBox(height: 20.5),

                _buildPhoneNumberTextField(thing),
                SizedBox(height: 10.5),
                ScopedModelDescendant<MainModel>(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return RaisedButton(
                      child: Text('Save'),
                      textColor: Colors.white,
                      onPressed: () => {
                            _submitForm(model.addThing, model.updateThing,
                                model.selectThing, model.selectedThingIndex),
                          });
                }),
              ]),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return DefaultTabController(
          length: 2,
          child: Scaffold(
            //drawer: buildDrawer(context),
            appBar: AppBar(
              title: Text("Manage Items"),
              bottom: TabBar(tabs: [
                Tab(text: 'Add Item', icon: Icon(Icons.add)),
                Tab(text: 'My posts', icon: Icon(Icons.list)),
              ]),
            ),
            body: TabBarView(children: [
              _addItem(context, model.selectedthing),
              ThingList()
            ]),

            bottomNavigationBar: buildBottomNavigator(context, _selectedindex),
          ));
    });
  }
}
                  // TextFormField(
                  //     decoration:
                  //         InputDecoration(labelText: "Locate where you found it")),
                  // LocationInput(),
                  // SizedBox(height: 10.0),
                  // _buildTimeTextField(context),
                  // SizedBox(
                  //   height: 25.5,
                  // ),
                  // TextFormField(
                  //     decoration: InputDecoration(
                  //         labelText: "Input the time when you found it")),
                 
                 
                  
                  // RaisedButton(
                  //   onPressed: () {},
                  //   child: Text("Post"),
                  // ),
                 

// Container(
//   padding: EdgeInsets.all(10.0),
//   child: Column(children: [
//     _buildNameTextField(context),
    // SizedBox(
    //   height: 10.5,
    // ),
//     ImageInput(),
//     SizedBox(
//       height: 10.5,
//     ),
//     _buildDescriptionTextField(context),
//     SizedBox(
//       height: 10.5,
//     ),
//     _buildDateTextField(context),
//     SizedBox(
//       height: 10.5,
//     ),
//     _buildLocationTextField(context),
//     SizedBox(
//       height: 10.5,
//     ),
//     _buildTimeTextField(context),
//     SizedBox(
//       height: 10.5,
//     ),
//     _buildEmailTextField(context),
//     SizedBox(height: 10.5),
//     _buildPhoneNumberTextField(context),
//     SizedBox(height: 10.5),
