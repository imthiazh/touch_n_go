import 'package:flutter/material.dart';

class TaskAutomation extends StatelessWidget {
  static const routeName = '/taskAutomation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Automation'),
      ),
      body: Center(
        child: Text(
          "!!!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }
}
