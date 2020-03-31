import 'package:e_commerce/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem({
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeCartItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure ?'),
                  content:
                      Text('Do you want to remove the item from the cart ?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text('NO'),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text('YES'),
                    ),
                  ],
                ));
      },
      direction: DismissDirection.endToStart,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListTile(
            title: Text(title),
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            trailing: Text('$quantity x'),
            subtitle: Text('Total: \$${(price * quantity)}'),
          ),
        ),
      ),
    );
  }
}
