

class ProductsResponse {
  final List<ProductModel> resultList;

  ProductsResponse({required this.resultList});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> productsJson = json['resultList'];
    List<ProductModel> products = productsJson
        .map((productJson) => ProductModel.fromJson(productJson))
        .toList();
    return ProductsResponse(resultList: products);
  }
}

class ProductModel {
  final String accountType;
  final bool signedUp;

  ProductModel({required this.accountType, required this.signedUp});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      accountType: json['accountType'],
      signedUp: json['signedUp'],
    );
  }
}

