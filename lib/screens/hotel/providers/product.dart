import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  Product({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.imageUrl,
  });
}
