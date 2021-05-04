import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

//import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
// import './orders_screen.dart';
import '../providers/product.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override


  Widget customBox(
      var text, var price, var textColor, var backgroundColor, var img) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          color: Color(backgroundColor),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            height: 220,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  radius: 38.0,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Image(
                      image: AssetImage(img),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "$text\n$price",
                      // "hello",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(textColor),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.redAccent,
                        child: IconButton(
                            splashColor: Colors.deepPurple,
                            icon: Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () {
                              // // cart.addItem(
                              // //     product.id, product.price, product.title);
                              // Scaffold.of(
                              //         context) //hide is used so that..when pressed, existing will hide and new will come
                              //     .hideCurrentSnackBar(); //of takes a context and establishes connection to nearest scaffold widget bts
                              // Scaffold.of(context).showSnackBar(
                              //   //snackbar is a popup coming from bottom. this scaffold connects with the nearest scaffold..i.e. with products overview (that has the product grid which is in the product item).
                              //   SnackBar(
                              //     content: Text(
                              //       'Added item to cart!',
                              //       style: TextStyle(color: Colors.blue[600]),
                              //     ),
                              //     backgroundColor: Colors.white,
                              //     duration: Duration(seconds: 2),
                              //     action: SnackBarAction(
                              //       label: 'UNDO',
                              //       onPressed: () {
                              //         // cart.removeSingleItem(product
                              //         //     .id); //this method is in cart.dart
                              //       },
                              //     ),
                              //   ),
                              // );
                            })),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isNull = true;
  String code;

  @override
  // void initState() {
    // TODO: implement initState
  //   super.initState();
    
  //   FlutterNfcReader.onTagDiscovered().listen((onData) {
  //     print(onData.id);
      
  //     String raw_json = onData.content;

  //     dynamic json_content =  raw_json.substring(7);

  //     print(json.decode(json_content));
      
  //     json_content = json.decode(json_content) as Map<String, dynamic>;

  //     code = json_content['code'];
  //     if (this.mounted) {
  //     setState(() {
  //       isNull = false;
  //     // print(user_cards[0])
  //     });
  //     }
      
  //     // setState(() {
  //     //   display=
  //     // });
  //     // if(onData.content==Null){
  //     //   print("DATA IS NULL");
  //     // }
  //     // else
  //     //   print("DATA IS there"+onData.content+"abc");
  //     // _openMap();
  //     // setState(() {
  //     //   writerController.text = "ID (hex): " + onData.id;
  //     //   nfcId = "ID (hex): " + onData.id;
  //     //   nfcont = "ID (hex): " + onData.content;
  //     // });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //   begin: Alignment.topRight,
      //   end: Alignment.bottomLeft,
      //   colors: [Colors.cyanAccent[400], Colors.blue[600]],
      // )),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: GradientAppBar(
          backgroundColorStart: Colors.blue[600],
          backgroundColorEnd: Colors.cyan,
          title: Text('e-Restaurant'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                color: Colors.blue[600],
                child: ch,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ],
        ),
        // drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //                 child: Text(code, style: TextStyle(
              //         fontSize: 36.0,
              //         fontWeight: FontWeight.w500,
              //         letterSpacing: 0.75,
              //       ),),
              // ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.75,
                  ),
                ),
              ),
              SizedBox(height: 15),
              ProductsGrid(_showOnlyFavorites),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Other Exciting Dishes",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.75,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    customBox("Burger", "₹ 52", 0xffDE9B4F, 0xffFFEAC5,
                        "assets/images/burger.png"),
                    customBox("Cheese", "₹ 48", 0xff698CAC, 0xffC3E3FF,
                        "assets/images/cheese.png"),
                    customBox("Doughnut", "₹ 17", 0xff51CF79, 0xffD7FBD9,
                        "assets/images/doughnut.png"),
                    customBox("Bufriesrger", "₹ 99", 0xffffa194, 0xffFFE4E0,
                        "assets/images/fries.png"),
                  ],
                ),
              ),
              SizedBox(
                height: 22.0,
              ),
              
            ],
          ),
        ),
        /*Column(
          children: <Widget>[
            ProductsGrid(_showOnlyFavorites),
            RaisedButton(
                child: Text('My Orders'),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(OrdersScreen.routeName);
                })
          ],
        ),*/
      ),
    );
  }
}
