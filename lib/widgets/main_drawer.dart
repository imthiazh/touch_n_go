import 'package:flutter/material.dart';
import 'package:touchngo/screens/attendance.dart';
import 'package:touchngo/screens/businessCard.dart';
import 'package:touchngo/screens/eAuthenticity.dart';
import 'package:touchngo/screens/home.dart';
import 'package:touchngo/screens/invitation/invitation_main.dart';
import 'package:touchngo/screens/tourist_main.dart';
import 'package:touchngo/screens/education.dart';
import 'package:touchngo/screens/hotel/screens/food_main.dart';
import 'package:touchngo/screens/sos.dart';
import 'package:touchngo/screens/taskAutomation.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Touch \'n\' Go',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          buildListTile('Home', Icons.home, () {
            Navigator.of(context).pushNamed('/');
          }),
          buildListTile('Business Card', Icons.business, () {
            Navigator.of(context).pushNamed(BusinessCard.routeName);
          }),
          buildListTile('Restaurant Menu', Icons.business, () {
            Navigator.of(context).pushNamed(FoodMain.routeName);
          }),
          buildListTile('Tourist Navigator', Icons.business, () {
            Navigator.of(context).pushNamed(TouristMain.routeName);
          }),
          buildListTile('Education', Icons.business, () {
            Navigator.of(context).pushNamed(Education.routeName);
          }),
          buildListTile('Invitation', Icons.mail_outline, () {
            Navigator.of(context).pushNamed(InvitationMain.routeName);
          }),
          buildListTile('Attendance', Icons.mail_outline, () {
            Navigator.of(context).pushNamed(Attendan.routeName);
          }),
          buildListTile('e-Authenticity', Icons.card_membership, () {
            Navigator.of(context).pushNamed(Authenticity.routeName);
          }),
          // buildListTile('Attendance', Icons.card_membership, () {
          //   Navigator.of(context).pushNamed(Attendance.routeName);
          // }),
          buildListTile('Task Automation', Icons.work, () {
            Navigator.of(context).pushNamed(TaskAutomation.routeName);
          }),
          buildListTile('SOS', Icons.help_center, () {
            Navigator.of(context).pushNamed(Sos.routeName);
          }),
        ],
      ),
    );
  }
}
