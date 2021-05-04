import 'dart:convert';

import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:touchngo/main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

enum FilterOptions {
  english,
  russian,
  french,
  spanish,
  hindi,
}

class TouristPage extends StatefulWidget {
  // static const routeName = '/tourist';
  String title;
  String url;
  String description;
  TouristPage({this.title, this.url, this.description});

  @override
  _TouristPageState createState() => _TouristPageState();
}

class _TouristPageState extends State<TouristPage> {
  GoogleTranslator translator = new GoogleTranslator();

  String input =
      'The Taj Mahal is an ivory-white marble mausoleum on the southern bank of the river Yamuna in the Indian city of Agra. It was commissioned in 1632 by the Mughal emperor Shah Jahan to house the tomb of his favourite wife, Mumtaz Mahal; it also houses the tomb of Shah Jahan himself. The tomb is the centrepiece of a 17-hectare complex, which includes a mosque and a guest house, and is set in formal gardens bounded on three sides by a crenellated wall.';
  String out;
  final lang = TextEditingController();
  var _showLanguage = 'en';

  bool isNull = true;
  String code;

  @override
  void initState() {
    runYouTubePlayer();
    // TODO: implement initState
    super.initState();

    // FlutterNfcReader.onTagDiscovered().listen((onData) {
    //   print(onData.id);

    //   String raw_json = onData.content;

    //   dynamic json_content = raw_json.substring(7);

    //   print(json.decode(json_content));

    //   json_content = json.decode(json_content) as Map<String, dynamic>;

    //   code = json_content['code'];
    //   if (this.mounted) {
    //     setState(() {
    //       isNull = false;
    //       // print(user_cards[0])
    //     });
    //   }
    // });
  }

  void trans(var _showLanguag) {
    translator.translate(widget.description, to: _showLanguag).then((output) {
      setState(() {
        out = output.toString();
        widget.description = out;
      });
      print(out);
    });
  }

  YoutubePlayerController _controller;

  void runYouTubePlayer() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        ));
  }

  // @override
  // void initState() {
  //   runYouTubePlayer();
  //   super.initState();
  // }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Tourist Spot'),
            actions: <Widget>[
              PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  setState(() {
                    if (selectedValue == FilterOptions.english) {
                      _showLanguage = 'en';
                      trans(_showLanguage);
                    } else if (selectedValue == FilterOptions.russian) {
                      _showLanguage = 'ru';
                      trans(_showLanguage);
                    } else if (selectedValue == FilterOptions.spanish) {
                      _showLanguage = 'es';
                      trans(_showLanguage);
                    } else if (selectedValue == FilterOptions.hindi) {
                      _showLanguage = 'hi';
                      trans(_showLanguage);
                    } else {
                      _showLanguage = 'fr';
                      trans(_showLanguage);
                    }
                  });
                },
                icon: Icon(
                  Icons.language_sharp,
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Text('English'),
                    value: FilterOptions.english,
                  ),
                  PopupMenuItem(
                    child: Text('Russian'),
                    value: FilterOptions.russian,
                  ),
                  PopupMenuItem(
                    child: Text('French'),
                    value: FilterOptions.french,
                  ),
                  PopupMenuItem(
                    child: Text('Hindi'),
                    value: FilterOptions.hindi,
                  ),
                  PopupMenuItem(
                    child: Text('Spanish'),
                    value: FilterOptions.spanish,
                  ),
                ],
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.place),
                        title: Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ],
                ),
              ),
              SizedBox(height: 5),
              player,
              SizedBox(height: 10),
              ////////////////////////////////////////////////////////////////////////////////
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      //leading: Icon(Icons.place),
                      title: Text('Description',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                    ),
                  ],
                ),
              ),
              /////////////////////////////////////////////////////////////////////////////////////
              Expanded(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(widget.description,
                          style: TextStyle(
                            color: Colors.black87,
                            //fontWeight: FontWeight.,
                            fontSize: 15,
                          )),
                      //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),

                      SizedBox(height: 5),
                      // TextField(
                      //   controller: lang,
                      // ),
                      // RaisedButton(
                      //     color: Colors.amber,
                      //     child: Text("Translate"),
                      //     onPressed: () {
                      //       trans();
                      //     }),
                      // Text(
                      //   out.toString(),
                      //   style: TextStyle(fontSize: 10),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
