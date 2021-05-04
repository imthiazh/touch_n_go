import 'package:flutter/foundation.dart';

class Invitation {
  final String phone;
  final String locationUrl;
  final String date;
  final String imageName;

  Invitation({
    @required this.phone,
    @required this.locationUrl,
    @required this.date,
    @required this.imageName,
  });
}
