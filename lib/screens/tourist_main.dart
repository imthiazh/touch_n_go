import 'package:flutter/material.dart';
import 'package:touchngo/screens/tourist.dart';
import 'dart:convert';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:http/http.dart' as http;
import 'package:touchngo/screens/touristClass.dart';

class TouristMain extends StatefulWidget {
  static const routeName = '/tourist';

  @override
  _TouristMainState createState() => _TouristMainState();
}

class _TouristMainState extends State<TouristMain> {
  bool isNull = true;
  List<Tourist> tourists = [];

  getDb(String name) async {
    Uri url = Uri.parse(
        "https://touch--n--go-default-rtdb.firebaseio.com/Tourist/" +
            name +
            ".json");
    dynamic rs = await http.get(url);
    print(json.decode(rs.body));
    print('vishal');
    dynamic json_rs = json.decode(rs.body) as Map<String, dynamic>;
    setState(() {
      // json_rs.forEach((prodId, prodData) {
      print(json_rs['title']);
      tourists.add(Tourist(
        title: json_rs['title'],
        url: json_rs['url'],
        description: json_rs['description'],
        // date: DateTime.parse(prodData['timestamp']),
        // progress: prodData['progress']
      ));
      isNull = false;
      print('vishal is a student');
      // });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FlutterNfcReader.onTagDiscovered().listen((onData) {
      String raw_json = onData.content;

      dynamic json_content = raw_json.substring(7);

      json_content = json.decode(json_content) as Map<String, dynamic>;

      String name = json_content["name"];

      getDb(name);
      //nfc code:fast_food
    });

    print("henlo");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-Shoppe',

      // theme: ThemeData(
      //   primarySwatch: Colors.green,
      //   accentColor: Colors.blue[600],
      //   fontFamily: 'Lato',
      // ),
      home: isNull
          ? Scaffold(
               appBar: GradientAppBar( 
            backgroundColorStart: Colors.blue[600], backgroundColorEnd: Colors.cyan,
            title: Text(
              'Tourist Spot',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                    )),
               ),
              // backgroundColor: Colors.greenAccent,
              body: Center(child: Text('''              No Data Found
Tap a NFC tag to get more info
        ''',style: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
          ),))
            )
          : TouristPage(
              title: tourists[0].title,
              url: tourists[0].url,
              description: tourists[0].description,
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
