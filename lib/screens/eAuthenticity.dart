import 'package:flutter/material.dart';

class Authenticity extends StatelessWidget {
  static const routeName = '/eAuthenticity';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('e-Authenticity'),
      ),
      body: Center(
        child: Text(
          "authentik",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }
}
