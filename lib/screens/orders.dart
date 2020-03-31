import 'package:e_commerce/providers/orders.dart' show Orders;
import 'package:e_commerce/widgets/app_drawer.dart';
import 'package:e_commerce/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = 'orders';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(
          ordersData.orders[i],
        ),
      ),
    );
  }
}
