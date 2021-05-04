import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Burger',
      price: 29.99,
      imageUrl: "assets/images/burger.png",
    ),
    Product(
      id: 'p2',
      title: 'Fries',
      price: 59.99,
      imageUrl: 'assets/images/fries.png',
    ),
    Product(
      id: 'p3',
      title: 'Taco',
      price: 19.99,
      imageUrl: 'assets/images/taco.png',
    ),
    Product(
      id: 'p4',
      title: 'Pizza',
      price: 49.99,
      imageUrl: 'assets/images/pizza.png',
    ),
    Product(
      id: 'p5',
      title: 'Hot Dog',
      price: 49.99,
      imageUrl: 'assets/images/hotdog.png',
    ),
    Product(
      id: 'p6',
      title: 'Sandwich',
      price: 49.99,
      imageUrl: 'assets/images/sandwich.png',
    ),
    Product(
      id: 'p7',
      title: 'Doughnut',
      price: 49.99,
      imageUrl: 'assets/images/doughnut.png',
    ),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) =>
        prod.id == id); //funtion which runs on every item tocheck condition
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
