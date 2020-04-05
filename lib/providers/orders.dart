import 'dart:convert';

import 'package:e_commerce/providers/cart.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class OrdersItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrdersItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrdersItem> _orders = [];

  List<OrdersItem> get orders => [..._orders];

  Future<void> addOrders(List<CartItem> cartProducts, double total) async {
    const url = 'https://my-eshop-5690b.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }));
    _orders.insert(
      0,
      OrdersItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
}
