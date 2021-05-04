import 'dart:convert';

import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:touchngo/main.dart';
import 'package:touchngo/screens/sos.dart';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:intl/intl.dart';

class InvitationPage extends StatefulWidget {
  String phone;
  String locationUrl;
  String date;
  String imageName;
  InvitationPage({this.phone, this.locationUrl, this.date, this.imageName});

  @override
  _InvitationPageState createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });
    print(DateTime.parse(widget.date).hour);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    DateTime dat = DateTime.parse(widget.date);
    int hr = dat.hour - 6;
    return Scaffold(
      appBar: AppBar(
        title: Text("You're Invited!",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          
          ///////////////////////////////////////////////////////////////////////
          FutureBuilder(
            future: _getImage(context, widget.imageName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: snapshot.data,
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  padding: EdgeInsets.all(150),
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                );
              }

              return Container();
            },
          ),

          
          
          //////////////////////////////////////////////////////////////////////////////
          Material(
            color: Colors.blueGrey,
            elevation: 14.0,
            shadowColor: Colors.grey,
            borderRadius: BorderRadius.circular(24.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Awaiting your presence on\n' +
                          DateTime.parse(widget.date)
                              .format(DateTimeFormats.american) +
                          '\nPlease save the date.',
                      style: TextStyle(
                        fontFamily: 'CormorantGaramond',
                        // decoration: TextDecoration.underline,
                        fontSize: 20,
                        color: Colors.white,
                        // fontWeight: FontWeight.w400,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          /////////////////////////////////////////////////////////////
          ElevatedButton(
            
            //     disabledColor: Colors.red,
            // disabledTextColor: Colors.black,

            child: Row(
              children: [
                Icon(
                  Icons.place,
                  size: 30,
                ),
                Text(
                  '   ' + widget.locationUrl,
                  style: TextStyle(fontFamily: 'CormorantGaramond', fontSize: 20),
                ),
              ],
            ),
            style: ButtonStyle(
              
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red),
                ),
              ),
            ),
            onPressed: () => launch(
                'https://www.google.com/maps/search/?api=1&query=' +
                    widget.locationUrl),
          ),

          //////////////////////////////////////////////////////
          ElevatedButton(
            //     disabledColor: Colors.red,
            // disabledTextColor: Colors.black,

            child: Text(
              'RSVP',
              style: TextStyle(fontFamily: 'CormorantGaramond', fontSize: 20),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.brown),
                ),
              ),
            ),
            onPressed: () {
              launch('https://wa.me/+91' +
                  widget.phone +
                  'Thanks for inviting ! Will see you on the day of wedding😄');
            },
          ),

          ///////////////////////////////////////////////////////
          ElevatedButton(
            //     disabledColor: Colors.red,
            // disabledTextColor: Colors.black,

            child: Text(
              'Schedule Reminder',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'CormorantGaramond', fontSize: 20),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blueAccent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            onPressed: () {
              launch('https://www.google.com/calendar/render?action=TEMPLATE&text=Attend_the_Wedding&dates=' +
                  dat.year.toString() +
                  '0' +
                  dat.month.toString() +
                  dat.day.toString() +
                  'T' +
                  (hr - 1).toString() +
                  '3000Z/' +
                  dat.year.toString() +
                  '0' +
                  dat.month.toString() +
                  dat.day.toString() +
                  'T' +
                  (hr).toString() +
                  '3000Z&details=For+details,+link+here:+http://www.example.com&location=' +
                  widget.locationUrl +
                  '&sf=true&output=xml');
            },
          ),

          //////////////////////////////////////////////////////////
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 350),
          StaggeredTile.extent(2, 150),
          StaggeredTile.extent(2, 80),
          StaggeredTile.extent(1, 70),
          StaggeredTile.extent(1, 70),
        ],
      ),
    );
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
