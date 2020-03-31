import 'package:e_commerce/providers/cart.dart';
import 'package:e_commerce/providers/orders.dart';
import 'package:e_commerce/providers/products.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/screens/edit_product_screen.dart';
import 'package:e_commerce/screens/orders.dart';
import 'package:e_commerce/screens/product_detail_screen.dart';
import 'package:e_commerce/screens/product_overview_screen.dart';
import 'package:e_commerce/screens/user_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        )
      ],
      child: MaterialApp(
        title: 'E-Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
        home: ProductOverViewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
