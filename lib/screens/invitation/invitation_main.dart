import 'package:date_time_format/date_time_format.dart';

import 'package:flutter/material.dart';
import 'package:touchngo/screens/invitation/invitation.dart';
import 'package:touchngo/screens/invitation/invitation_class.dart';
import 'package:touchngo/screens/tourist.dart';
import 'dart:convert';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:http/http.dart' as http;
import 'package:touchngo/screens/touristClass.dart';

class InvitationMain extends StatefulWidget {
  static const routeName = '/invitation';

  @override
  _InvitationMainState createState() => _InvitationMainState();
}

class _InvitationMainState extends State<InvitationMain> {
  bool isNull = true;
  List<Invitation> invitations = [];

  @override
  void initState() {
    super.initState();

    FlutterNfcReader.onTagDiscovered().listen((onData) {
      print(onData.id);

      String raw_json = onData.content;

      dynamic json_content = raw_json.substring(7);

      print(json.decode(json_content));

      json_content = json.decode(json_content) as Map<String, dynamic>;

      setState(() {
        isNull = false;
        invitations.add(Invitation(
          phone: json_content["p"],
          locationUrl: json_content["l"],
          date: json_content["d"],
          imageName: json_content["i"],
          // color:
        ));
        // print(user_cards[0])
      });
    });

    print("henlo");
  }

  @override
  Widget build(BuildContext context) {
    // String phoneNo;
    // String location_url;
    // String daTe;
    // String image_url;

    return MaterialApp(
      title: 'Invitation',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue[600],
        fontFamily: 'Lato',
      ),
      home: isNull
          ? Scaffold(
              appBar: AppBar(
                title: const Text('Wedding Invite'),
              ),
              backgroundColor: Colors.white,
              body: Center(child: Column(
      children: [
        SizedBox(height: 150),
        Container(
          width: 200, height: 200,
          child: Image(
              image: AssetImage('assets/images/wedding-arch.png')
            ),
        ),
        SizedBox(height: 50),
        Text('''
Tap an invite to view!
            ''',style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
              ),),
      ],
    ))
            )
          : InvitationPage(
              phone: invitations[0].phone,
              locationUrl: invitations[0].locationUrl,
              date: invitations[0].date,
              imageName: invitations[0].imageName,
            ),
      // routes: {
      //   // ProductDetailScree.routeName: (ctx) => ProductDetailScreen(),
      //   CartScreen.routeName: (ctx) => CartScreen(),
      //   // OrdersScree.routeName: (ctx) => OrdersScreen(),
      //   // UpiPayment.routeName: (ctx) => UpiPayment(0.0),
      // });
    );
  }
}
