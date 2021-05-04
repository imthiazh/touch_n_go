import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:touchngo/screens/learn.dart';
import 'package:touchngo/screens/test.dart';

class Education extends StatelessWidget {
  static const routeName = '/education';
  AudioPlayer audioPlayer = new AudioPlayer();

  play() async {
    // int result = await audioPlayer.play("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
    int result = await audioPlayer.play("https://firebasestorage.googleapis.com/v0/b/touch--n--go.appspot.com/o/apple_eng.mp3?alt=media&token=df7c128e-8a75-4a60-a2ff-ea385514279f");
    // int result = await audioPlayer.play("assets/audio/apple_eng.mp3", isLocal: true);
    if (result == 1) {
      // success
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:2,
          child: Scaffold(
        appBar: AppBar(
          title: Text('Learn the Alphabets!'),
          bottom: TabBar(
            indicatorColor: Colors.white,
unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(child: Text("Learn"),),
                  Tab(child: Text("Test"),),
                ],
              ),
        ),
        body: TabBarView(
            children: [
              Learn(),
              // Center(
              //   child: RaisedButton(child: Text("Hello"), onPressed: (){
              //     var url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
              //     play();
              //   }),
              // ),
              // Icon(Icons.directions_transit),
              Test()
              // Icon(Icons.directions_bike),
            ],
          ),
      ),
    );
  }
}
