import 'package:cool_outfits/constants.dart';
import 'package:cool_outfits/models/product.dart';
import 'package:cool_outfits/services/store.dart';
import 'package:cool_outfits/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .2),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  hint: 'Product Name',
                  onClick: (value) {
                    _name = value;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hint: 'Product Price',
                  onClick: (value) {
                    _price = value;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hint: 'Product Description',
                  onClick: (value) {
                    _description = value;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hint: 'Product Category',
                  onClick: (value) {
                    _category = value;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hint: 'Product Location',
                  onClick: (value) {
                    _imageLocation = value;
                  },
                ),
                SizedBox(height: 10),
                RaisedButton(
                  child: Text('Add Product'),
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();
                      _store.editProduct(
                          ({
                            kProductName: _name,
                            kProductLocation: _imageLocation,
                            kProductCategory: _category,
                            kProductDescription: _description,
                            kProductPrice: _price,
                          }),
                          product.pId);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
