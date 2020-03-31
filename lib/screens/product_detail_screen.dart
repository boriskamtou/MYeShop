import 'package:e_commerce/providers/products.dart';
import 'package:flutter/cupertino.dart';
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
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              productData.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '\$${productData.price}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${productData.description}',
            textAlign: TextAlign.center,
            softWrap: true,
          )
        ],
      ),
    );
  }
}
