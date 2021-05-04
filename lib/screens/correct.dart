import 'package:flutter/material.dart';

class Correct extends StatelessWidget {
  // static const routeName = '/verify';
  bool status;
  
  Correct(bool answer){
    this.status = answer;
    print(status);
  }

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
          child: Center(
            child: status ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 50),
                Text("Correct Answer !",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),),
                Icon(Icons.check, color: Colors.green, size: 130,),
                Text("+1 point",style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                      ),),
              ],
            ) : 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text("Try Again ...",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),),
                      SizedBox(height: 20),
                Icon(Icons.replay, color: Colors.red, size: 130,),
                // Text("+1 point",style: TextStyle(
                //         color: Colors.green,
                //         fontSize: 18,
                //       ),),
              ],
            )
            //Icon(Icons.replay, color: Colors.red)
            ,
          )
        ),
      ),
    );
  }
}
