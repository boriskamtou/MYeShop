import 'dart:convert';

import 'package:e_commerce/providers/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get prodFavs {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Product findProductByID(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://my-eshop-5690b.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://my-eshop-5690b.firebaseio.com/products.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void updateProduct(String productId, Product newProduct) {
    final productIndex = _items.indexWhere((prod) => prod.id == productId);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String productId) {
    _items.removeWhere((prod) => prod.id == productId);
    notifyListeners();
  }
}
