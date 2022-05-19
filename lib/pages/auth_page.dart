// import 'dart:html';

import 'package:flutter/material.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

enum AuthMode { Signup, Login }

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'name': null,
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  // String _username;
  // String _userEmail;
  // String _password;
  bool _acceptterms = true;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _passConfirmController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        image: AssetImage('assets/background.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.grey.withOpacity(0.5),
          BlendMode.dstATop,
        ));
  }

  Widget _buildUserNameTextField() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: 'User Name',
          filled: true,
          icon: Icon(
            Icons.account_box,
            size: 30,
            color: Colors.blue,
          ),
          fillColor: Colors.white,
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          //helperText: 'Type your Real Name here',
          //helperStyle: TextStyle(fontSize: 15),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(width: 2, color: Colors.blue),
          // ),
        ),
        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty) return 'The name consists only of characters';
        },
        onSaved: (String value) {
          _formData['name'] = value;
        });
  }

  Widget _buildUserEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'E_Mail',
        filled: true,
        icon: Icon(
          Icons.email,
          size: 30,
          color: Colors.blue,
        ),
        fillColor: Colors.white,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        //helperText: 'Type your Real Name here',
        helperStyle: TextStyle(fontSize: 15),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(width: 2, color: Colors.blue),
        // ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) return '* Required';
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passConfirmController,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
        filled: true,
        icon: Icon(
          Icons.mode_edit,
          size: 30,
          color: Colors.blue,
        ),
        fillColor: Colors.white, //helperText: 'Password must be More Than 8',
        helperStyle: TextStyle(fontSize: 20),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(width: 2, color: Colors.blue),
        // ),
      ),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 8) return 'Password  Invaild';
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
        filled: true,
        icon: Icon(
          Icons.mode_edit,
          size: 30,
          color: Colors.blue,
        ),
        fillColor: Colors.white, //helperText: 'Password must be More Than 8',
        helperStyle: TextStyle(fontSize: 20),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(width: 2, color: Colors.blue),
        // ),
      ),
      obscureText: true,
      validator: (String value) {
        if (_passConfirmController.text != value) return 'Passwords not match';
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      activeColor: Colors.blue,
      value: _acceptterms,
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text(
        'Accept Terms',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  void _submitForm(Function login) {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();
    login(_formData['email'], _formData['password'], _formData['name']);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Center(child: Text('Authentication Page')),
      ),
      body: Container(
        padding: EdgeInsets.all(10.5),
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    _buildUserNameTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildUserEmailTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    _authMode == AuthMode.Signup
                        ? _buildPasswordConfirmTextField()
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),

                    // _buildAcceptSwitch(),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            _authMode = _authMode == AuthMode.Login
                                ? AuthMode.Signup
                                : AuthMode.Login;
                          });
                        },
                        child: Text(
                            'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}')),
                    SizedBox(
                      height: 10,
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return RaisedButton(
                          textColor: Colors.white,
                          child: Text('LOGIN'),
                          onPressed: () => _submitForm(model.login),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
