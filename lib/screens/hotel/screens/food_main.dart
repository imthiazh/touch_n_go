import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:touchngo/screens/hotel/providers/cart.dart';
import 'package:touchngo/screens/hotel/providers/orders.dart';
import 'package:touchngo/screens/hotel/providers/products.dart';
import 'package:touchngo/screens/hotel/screens/cart_screen.dart';
import './food_overview_screen.dart';

class FoodMain extends StatelessWidget {
  static const routeName = '/mainmenu';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
          title: 'e-Shoppe',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.blue[600],
            fontFamily: 'Lato',
          ),
          home: ProductsOverviewScreen(),
          routes: {
            // ProductDetailScree.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            // OrdersScree.routeName: (ctx) => OrdersScreen(),
            // UpiPayment.routeName: (ctx) => UpiPayment(0.0),
          }),
    );
  }
}
