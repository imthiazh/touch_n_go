import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:touchngo/screens/attendance/reminder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'dart:convert';
import 'dart:math';
import 'attendance_class.dart';

class AttendanceMain extends StatefulWidget {
  static const routeName = '/attendance';

  @override
  _AttendanceMainState createState() => _AttendanceMainState();
}

class _AttendanceMainState extends State<AttendanceMain> {
  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });

    return image;
  }

  bool isNull = true;
  List<Attendance> students = [];
  String fac_name;
  String course;
  List<String> recipients = ["8015267555", "8838794840", "9941625323"];

  String task_type;
  String task;
  String img;

  @override
  initState() {
    super.initState();

    // Stream<NDEFMessage> stream = NFC.readNDEF();

// stream.listen((NDEFMessage message) {
//     //print("records: ${message.records.length}");
// });
    // writerController.text = 'Flutter NFC Scan';
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      print(onData.id);

      String raw_json = onData.content;

      dynamic json_content = raw_json.substring(7);

      print(json.decode(json_content));

      json_content = json.decode(json_content) as Map<String, dynamic>;

      setState(() {
        // isNull = false;
        if (json_content["c"] == "teacher") {
          isNull = false;
          fac_name = json_content["n"];
          course = json_content["co"];
        } else if (json_content["c"] == "student") {
          students.add(Attendance(
            name: json_content["n"],
            rollNo: json_content["r"],
            phoneNo: json_content["p"],
            imageName: json_content["i"],
            // color:
          ));
          img = json_content["i"];
          recipients.remove(json_content["p"]);
          print(img);
        }
        // print(user_cards[0])
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void _sendSMS(String message, List<String> recipents) async {
      String _result = await sendSMS(message: message, recipients: recipients)
          .catchError((onError) {
        print(onError);
      });
      print('success');
    }

    // List<String> sendd = recipents

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: isNull
          ? Center(
              child: Text(
                '''              No Cards Found
Tap a NFC tag to add contacts
        ''',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/woman-teacher.png'),
                            radius: 50.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: Colors.red,
                          elevation: 14.0,
                          shadowColor: Colors.grey,
                          borderRadius: BorderRadius.circular(24.0),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'FACULTY : ' + fac_name,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'COURSE : ' + course,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'DATE : MARCH 25 2021',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.yellow[600],
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                ),
                ListTile(
                  leading: Icon(
                    Icons.school,
                    size: 40,
                  ),
                  title: Text('Students\' List',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      )),
                  //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
                Container(
                  child: students.length == 0
                      ? Center(
                          child: Text(
                            'NO STUDENTS',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: students.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://th.bing.com/th/id/R044cdd256a620c0c1116bdb87b70a81a?rik=Gp68EIEfPkpwrw&riu=http%3a%2f%2fd2trtkcohkrm90.cloudfront.net%2fimages%2femoji%2fapple%2fios-10%2f256%2fman-student.png&ehk=VkB%2buu3ZNWGBQwJ1rCWTI1%2fB9zc4DvAjU3aFcTK9kWI%3d&risl=&pid=ImgRaw'),
                                    radius: 20.0),
                                title:
                                    Text('Name: ' + '${students[index].name}'),
                                subtitle: Text(
                                    'Roll No: ' + '${students[index].rollNo}'),
                              ),
                            );
                          }),

                  // FutureBuilder(
                  //     future: _getImage(context, img),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.done) {
                  //         return ListView.builder(
                  //           itemCount: students.length,
                  //           itemBuilder: (BuildContext context, int index) {
                  //             final image = snapshot.data;
                  //             return Card(
                  //               margin: EdgeInsets.symmetric(vertical: 10),
                  //               child: ListTile(
                  //                 dense: false,
                  //                 leading: Image.network(image),
                  //                 title: Text(
                  //                     'Name: ' + '${students[index].name}'),
                  //                 subtitle: Text('Roll No: ' +
                  //                     '${students[index].rollNo}'),
                  //               ),
                  //             );
                  //           },
                  //         );
                  //       }
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       }
                  //     },
                  //   ),
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.yellow[600],
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      //     disabledColor: Colors.red,
                      // disabledTextColor: Colors.black,

                      child: Text(
                        'Send SMS',
                        style: TextStyle(fontSize: 23),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.brown),
                          ),
                        ),
                      ),
                      onPressed: () {
                        String message =
                            'You have been marked absent for today\'s CIP class on ' +
                                DateTime.now()
                                    .format(DateTimeFormats.american)
                                    .toString();
                        // List<String> recipents = [
                        //   "8015267555",
                        //   "8838794840",
                        //   "9941625323"
                        // ];

                        _sendSMS(message, recipients);
                      },
                    ),
                    ElevatedButton(
                      //     disabledColor: Colors.red,
                      // disabledTextColor: Colors.black,

                      child: Text(
                        'REMINDER',
                        style: TextStyle(fontSize: 23),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.brown),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Reminder.routeName);
                      },
                    ),
                  ],
                )
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

// CircleAvatar(
//                                     backgroundImage: NetworkImage(
//                                         'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
//                                     radius: 20.0),
