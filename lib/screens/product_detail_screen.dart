import 'package:e_commerce/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context).settings.arguments as String;
    final productData =
        Provider.of<Products>(context).findProductByID(productID);
    return Scaffold(
      appBar: AppBar(
        title: Text(productData.title),
      ),
      body: Container(),
    );
  }
}
