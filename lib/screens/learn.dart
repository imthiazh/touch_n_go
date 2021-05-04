import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

class Learn extends StatefulWidget {
  // static const routeName = '/education';
  @override
  _LearnState createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  AudioPlayer audioPlayer = new AudioPlayer();
  bool isNull = true;
  String desc;
  String img;
  String url;
  String code;

  getDb(String code) async {
    dynamic url = Uri.parse("https://touch--n--go-default-rtdb.firebaseio.com/Education/"+code+".json");
    dynamic rs = await http.get(url);
    print(json.decode(rs.body));
    dynamic json_rs=json.decode(rs.body) as Map<String, dynamic>;
    setState(() {
      desc = json_rs["description"];
      url = json_rs["url"];
      img = json_rs["img"];
      play(url);
      isNull = false;
    });
    print(desc);
      // isNull=false;
    //   json_rs.forEach((prodId, prodData) {

    //     // products.add(Product(
    //     //   id: prodData['id'],
    //     //   title: prodData['title'],
    //     //   price: prodData['price'],
    //     //   imageUrl: prodData['imageUrl'],
    //     //   // date: DateTime.parse(prodData['timestamp']),
    //     //   // progress: prodData['progress']
    //     // ));
      
    //   });
    // });
      
  }

  @override
  initState() {
    super.initState();
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      print(onData.id);
      
      String raw_json = onData.content;

      dynamic json_content =  raw_json.substring(7);

      print(json.decode(json_content));
      
      json_content = json.decode(json_content) as Map<String, dynamic>;

         
      
      // setState(() {
        // isNull = false;
        code = json_content["code"];
        // desc = json_content["description"];
        // url = json_content["url"];

      
      // });

      // print(desc);
      // print(url);
      // 
      getDb(code);
      // play();
      
      
    });
  }

  play(String url) async {
    // int result = await audioPlayer.play("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
    int result = await audioPlayer.play(url);
    // int result = await audioPlayer.play("assets/audio/apple_eng.mp3", isLocal: true);
    if (result == 1) {
      // success
    }
  }

  @override
  Widget build(BuildContext context) {
    return isNull ? Center(child: Column(
      children: [
        SizedBox(height: 150),
        Container(
          width: 200, height: 200,
          child: Image(
              image: AssetImage('assets/images/abc_block.png')
            ),
        ),
        SizedBox(height: 50),
        Text('''
Tap a tag to start learning!
            ''',style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
              ),),
      ],
    )) : Center(
      child: Column(
        children: [
          SizedBox(height: 40),
          Text("'"+desc[0]+"'",style: TextStyle(
                color: Colors.blue[300],
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),),
          SizedBox(height: 25),
          Image(
            image: AssetImage(img),
            width: 300,
            height: 300,
          ),
          SizedBox(height: 50),
          Text(desc,style: TextStyle(
                color: Colors.blue[300],
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationThickness: 2.0,
                fontSize: 30.0,
              ),),
              SizedBox(height: 30),
          RawMaterialButton(
  onPressed: () {},
  elevation: 2.0,
  fillColor: Colors.blue,
  child: Icon(
    Icons.volume_up_rounded,
    size: 35.0,
    color: Colors.white,
  ),
  padding: EdgeInsets.all(15.0),
  shape: CircleBorder(),
)
          // Icon()
        ]
      ),
    );
  }
}
