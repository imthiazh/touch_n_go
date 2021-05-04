import 'package:flutter/material.dart';

class Verify extends StatelessWidget {
  static const routeName = '/verify';

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
          child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
      border: Border.all(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20))
  ),
          // color: Colors.white,
          width: 320,
          height: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                
                        'Thanks for joining!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue[200],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'
                        ),
                      ),
                      SizedBox(height: 2),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  
                          'Welcome to Touch n Go, please verify your email address to activate your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue[200],
                            fontSize: 18,
                            fontFamily: 'Raleway'
                          ),
                        ),
              ),
              RaisedButton(child: Text("Done", style: TextStyle(
                            color: Colors.white,
                            // fontSize: 18,
                            fontFamily: 'Raleway'
                          ),), color: Colors.blue, onPressed: (){},)
            ],
          ),
        ),
      ),
    );
  }
}
