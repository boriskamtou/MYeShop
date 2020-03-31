import 'package:e_commerce/providers/cart.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/widgets/app_drawer.dart';
import 'package:e_commerce/widgets/badge.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverViewScreen extends StatefulWidget {
  static const routeName = '/product-overview-screen';
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool productFavs = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedOption) {
              setState(() {
                if (FilterOptions.Favorites == selectedOption) {
                  productFavs = true;
                } else {
                  productFavs = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: ProductsGrid(
        productFavorites: productFavs,
      ),
    );
  }
}
