import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:touchngo/screens/correct.dart';
import 'package:touchngo/screens/verify.dart';

class Test extends StatefulWidget {
  // static const routeName = '/education';
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  AudioPlayer audioPlayer = new AudioPlayer();
  bool isNull = true;
  // List<String> codes = ['a_eng', 'b_eng', 'c_eng'];
  List<String> codes = ['a_eng', 'b_eng', 'c_eng', 'd_eng', 'e_eng', 'f_eng'];
  String desc;
  String img;
  String url;
  String code;

  List<String> l_desc  = [];
  List<String> l_img  = [];
  List<String> l_url  = [];
  List list;

  List<int> indexes;
  int score=0;
  int randomNumber1;
    int randomNumber2;
    int randomNumber3;
  int curr_index=0;

  getDb(List<int> indexes) async {
    List<String> mycodes = [];
    for(int i=0; i<3; i++){
      print("Adding"+codes[indexes[i]]);
      mycodes.add(codes[indexes[i]]);
    }
    for(int i=0; i<3; i++){
      dynamic url = Uri.parse("https://touch--n--go-default-rtdb.firebaseio.com/Education/"+mycodes[i]+".json");
    dynamic rs = await http.get(url);
    print("Curr "+i.toString());
    print(json.decode(rs.body));
    dynamic json_rs=json.decode(rs.body) as Map<String, dynamic>;
    
      l_desc.add(json_rs["description"]);
      l_url.add(json_rs["url"]);
      l_img.add(json_rs["img"]);
      // url = json_rs["url"];
      // img = json_rs["img"];
      // play(url);
      
    
    // print(desc);
    }
    
    setState(() {isNull = false;});
      
  }

  @override
  initState() {
    super.initState();

    Random random = new Random();
    List<int> indexes = [];
    
    // int randomNumber1 = random.nextInt(3);
    // int x;
    // while( (x=random.nextInt(3)) == randomNumber1){

    // }
    // int randomNumber2 = random.nextInt(3);
    // int randomNumber3 = random.nextInt(3);
    list = List.generate(6, (i) => i);

// shuffle it 
list.shuffle();

// take the numbers now, they are always unique
int randomNumber1 = list[0];
int randomNumber2 = list[1];
int randomNumber3 = list[2];
    indexes.add(randomNumber1); indexes.add(randomNumber2); indexes.add(randomNumber3);
    print("Test1");
    getDb(indexes);
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      print(onData.id);
      
      String raw_json = onData.content;

      dynamic json_content =  raw_json.substring(7);

      print(json.decode(json_content));
      
      json_content = json.decode(json_content) as Map<String, dynamic>;

         
      

        code = json_content["code"];

        if(code==codes[list[curr_index]]){
          print("CORRECT");
          score++;
          setState(() {
            curr_index++;
          });
          new Future.delayed(
            Duration.zero, () {
              showDialog(context: context, 
              builder: (BuildContext context) {
          
                return Correct(true);
              }
              );
            }
          );
        }
        else{
          print("WRONG");
          setState(() {
            curr_index++;
          });
          new Future.delayed(
            Duration.zero, () {
              showDialog(context: context, 
              builder: (BuildContext context) {
                return Correct(false);
                
              }
              );
            }
          );
        }

          

          
        }
        
      // getDb(code);
      
      
      
    );
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
        SizedBox(height: 250),
        // Container(
        //   width: 200, height: 200,
        //   child: 
        // ),
        SizedBox(height: 50),
        Text('''
Loading...
            ''',style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
              ),),
      ],
    )) : 
    (curr_index<3) ? Center(
      child: Column(
        children: [
          SizedBox(height: 200),
          // Image(
          //   image: AssetImage(l_img[curr_index])
          // ),
          // Container(
          //   width: 200, height: 200,
          //   child: Image(
          //       image: AssetImage('assets/images/abc_block.png')
          //     ),
          // ),
          // Text(""),
          Text('''
Tap on the object starting with : 
            ''',style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
              ),),

              Text("'"+l_desc[curr_index][0]+"'",style: TextStyle(
                color: Colors.blue[300],
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
              ),),
          // Text(),
        ]
      ),
    )
    : Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 160),
        Text("Your Score!",style: TextStyle(
                color: Colors.grey,
                fontSize: 40.0,
              ),),
              // SizedBox(height: 20),
             
              SizedBox(height: 60),
        SmoothStarRating(
          rating: score.toDouble(),
          isReadOnly: false,
          size: 60,
          filledIconData: Icons.star,
          halfFilledIconData: Icons.star_half,
          defaultIconData: Icons.star_border,
          starCount: 3,
          allowHalfRating: true,
          spacing: 0.1,
          color: Colors.yellow,
          borderColor: Colors.yellow,
          onRated: (value) {
            print("rating value -> $value");
            // print("rating value dd -> ${value.truncate()}");
          },
        ),
        SizedBox(height: 40),
        Text("Answered correctly : ",style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
              ),),
         Text(score.toString()+" out of 3",style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
              ),),

              SizedBox(height: 40),
        RawMaterialButton(
  onPressed: () {
    setState(() {
      curr_index=0;
      score=0;
    });
  },
  elevation: 2.0,
  fillColor: Colors.blue,
  child: Icon(
    Icons.replay,
    size: 35.0,
    color: Colors.white,
  ),
  padding: EdgeInsets.all(15.0),
  shape: CircleBorder(),
)

      ],
    );
  }
}
