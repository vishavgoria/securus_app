
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/utils/AccountTypeEnum.dart';
import 'package:test1/utils/app_constants.dart';

import '../view_models/LoginViewModel.dart';
import '../view_models/ProductsViewModel.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsViewModel = Provider.of<ProductsViewModel>(context, listen: false);
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      productsViewModel.setAuthenticationInfo(
        loginViewModel.authResponseModel.result?.contactId,
        loginViewModel.authorization,
      );

      productsViewModel.fetchProducts(productsViewModel.contactId ?? 0,productsViewModel.authorization ?? '');
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(productPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              loginViewModel.logout();
              // Navigate back to the login page
              Navigator.pushReplacementNamed(context, loginPageRoute);
            },
          ),
        ],
      ),
      body: Consumer<ProductsViewModel>(
        builder: (context, viewModel, _) => ListView.builder(
          itemCount: viewModel.products.length,
          itemBuilder: (context, index) {
            final product = viewModel.products[index];
            return Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Border color
                borderRadius: BorderRadius.circular(8.0), // Border radius
              ),
              child: ListTile(

                title: Text(product.accountType),
                trailing: product.accountType == AccountTypeEnum.SECURUSDEBIT.toString()
                    ? ElevatedButton(
                  onPressed: () {
                    //TODO: Handle FUND NOW button
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: const Text(fundNowBtnLbl),
                )
                    : product.signedUp
                    ? ElevatedButton(
                  onPressed: () {
                    //TODO: Handle LAUNCH button
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: const Text(launchBtnLbl),
                )
                    : ElevatedButton(
                  onPressed: () {
                    //TODO: Handle SIGN UP button
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text(signUpBtnLbl),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
