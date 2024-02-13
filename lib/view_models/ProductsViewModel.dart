
import 'package:flutter/material.dart';
import 'package:test1/rest/api_constants.dart';
import '../model/ProductResponse.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


class ProductsViewModel extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  int? _contactId;
  int? get contactId => _contactId;

  String? _authorization;
  String? get authorization => _authorization;

  void setAuthenticationInfo(int? contactId, String? authorization) {
    _contactId = contactId;
    _authorization = authorization;
    notifyListeners();
  }


  Future<void> fetchProducts(int contactId, String authorization) async {
    final String url = '$BASE_URL$PRODUCT_URL?contactId=$contactId';

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': authorization},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> productListJson = responseData['resultList'];

        _products = productListJson
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();
      } else {
        print('Failed to fetch products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching products: $e');
    }

    notifyListeners();
  }
}

