import 'package:e_commerce/providers/cart.dart' show Cart;
import 'package:e_commerce/providers/orders.dart';
import 'package:e_commerce/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      '\$${cart.totalAccount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //TODO:
                      Provider.of<Orders>(context, listen: false).addOrders(
                        cart.items.values.toList(),
                        cart.totalAccount,
                      );
                      cart.clear();
                    },
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => CartItem(
                title: cart.items.values.toList()[i].title,
                quantity: cart.items.values.toList()[i].quantity,
                price: cart.items.values.toList()[i].price,
                id: cart.items.values.toList()[i].id,
                productId: cart.items.keys.toList()[i],
              ),
              itemCount: cart.items.length,
            ),
          )
        ],
      ),
    );
  }
}
