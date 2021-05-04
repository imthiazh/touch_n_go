import 'dart:convert';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touchngo/screens/hotel/providers/product.dart';
//import 'package:reapp/anti_chew_shop/screens/orders_screen.dart';

// import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatefulWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {

  List<Product> products=[];
  bool isNull = true;

  getDb(String code) async {
    Uri url = Uri.parse("https://touch--n--go-default-rtdb.firebaseio.com/Restaurant/"+code+".json");
    dynamic rs = await http.get(url);
    print(json.decode(rs.body));
    dynamic json_rs=json.decode(rs.body) as Map<String, dynamic>;
    setState(() {
      isNull=false;
      json_rs.forEach((prodId, prodData) {
        products.add(Product(
          id: prodData['id'],
          title: prodData['title'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          // date: DateTime.parse(prodData['timestamp']),
          // progress: prodData['progress']
        ));
      
      });
    });
      
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FlutterNfcReader.onTagDiscovered().listen((onData){
      String raw_json = onData.content;

      dynamic json_content =  raw_json.substring(7);

      json_content = json.decode(json_content) as Map<String, dynamic>;

      String code = json_content["code"];
      print(code);

      getDb(code);
      //nfc code:fast_food
    });

    print("hello");
    
  }


  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    // final products = productsData.items;
    // dynamic products = [
    //   Product(id: "id1", title: "Idli", price: 25.00, imageUrl: "assets/images/fries.png"),
    //   Product(id: "id2", title: "Dosa", price: 25.00, imageUrl: "assets/images/fries.png")
    // ];
    return isNull ? Container(child: Center(child: Text('''              No Data Found
Tap a NFC tag to check out a menu
        ''',style: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
          ),)), height: 500,) : 
    Container(
      height: 500,
      color: Colors.white30,
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ProductItem(
          product: products[i]
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
