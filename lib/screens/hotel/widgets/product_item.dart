import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {

  Product product;

  ProductItem({this.product}); 
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(
            //  // ProductDetailScreen.routeName,
            //   //arguments: product.id,
            // );
          },
          child: Container(
            width: 15,
            height: 15,
            child: Image.asset(
              product.imageUrl,
              // width: 15,
              // height: 15,
              // "assets/images/burger.png",
              // fit: BoxFit.scaleDown,  
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black12,
          // leading: Consumer<Product>(
          //   builder: (ctx, product, _) => IconButton(
          //     icon: Icon(
          //       product.isFavorite ? Icons.favorite : Icons.favorite_border,
          //     ),
          //     // color: Theme.of(context).accentColor,
          //     color: Colors.white,
          //     onPressed: () {
          //       product.toggleFavoriteStatus();
          //     },
          //   ),
          // ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.add_circle,
              // color: Colors.blue[600],
              color: Colors.white,
            ),
            onPressed: () {
              // cart.addItem(product.id, product.price, product.title);
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(
                      context) //hide is used so that..when pressed, existing will hide and new will come
                  .hideCurrentSnackBar(); //of takes a context and establishes connection to nearest scaffold widget bts
              Scaffold.of(context).showSnackBar(
                //snackbar is a popup coming from bottom. this scaffold connects with the nearest scaffold..i.e. with products overview (that has the product grid which is in the product item).
                SnackBar(
                  content: Text(
                    'Added item to cart!',
                    style: TextStyle(color: Colors.blue[600]),
                  ),
                  backgroundColor: Colors.white,
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(
                          product.id); //this method is in cart.dart
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
