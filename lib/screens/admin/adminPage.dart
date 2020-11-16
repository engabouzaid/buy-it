import 'package:cool_outfits/screens/admin/addProduct.dart';

import 'package:cool_outfits/screens/admin/manageProduct.dart';
import 'package:cool_outfits/screens/admin/viewOrders.dart';
import 'package:flutter/material.dart';
import 'package:cool_outfits/constants.dart';

class AdminPage extends StatelessWidget {
  static String id = 'AdminPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
              child: Text('Add Product'),
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              }),
          RaisedButton(
              child: Text('Edit Product'),
              onPressed: () {
                Navigator.pushNamed(context, ManageProducts.id);
              }),
          RaisedButton(
              child: Text('View Orders'),
              onPressed: () {
                Navigator.pushNamed(context, ViewOrders.id);
              }),
        ],
      ),
    );
  }
}
