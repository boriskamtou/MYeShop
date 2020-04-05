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
                  OrderButton(cart: cart),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.cart.totalAccount <= 0 || _isLoading)
          ? null
          : () async {
            setState(() {
              _isLoading = true;
            });
            await Provider.of<Orders>(context, listen: false)
                  .addOrders(
                widget.cart.items.values.toList(),
                widget.cart.totalAccount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
      child: _isLoading ? CircularProgressIndicator() : Text(
        'ORDER NOW',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
