import 'package:cool_outfits/functions.dart';
import 'package:cool_outfits/models/product.dart';
import 'package:cool_outfits/screens/user/productInfo.dart';
import 'package:flutter/material.dart';

Widget productsView(String pCategory, List<Product> allProducts) {
  List<Product> products;
  products = getProductByCategory(pCategory, allProducts);
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: .8),
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductInfo.id, arguments: products[index]);
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                products[index].pLocation,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: .6,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].pName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('\$ ${products[index].pPrice}'),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    itemCount: products.length,
  );
}
