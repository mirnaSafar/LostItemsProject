import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  Widget _buildText() {
    return Text(
      'Missing App ',
      style: TextStyle(
        fontSize: 40,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return RaisedButton.icon(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/auth');
      },
      icon: Icon(Icons.skip_next),
      label: Text('Skip'),
    );
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      image: AssetImage('assets/firstbackground.jpg'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Welcome'),
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.search,
                size: 100,
                color: Colors.amberAccent,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildText(),
            SizedBox(height: 10.2),
            _buildButton(context),
          ],
        ),
      ),
    );
  }
}
