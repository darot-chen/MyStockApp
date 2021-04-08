import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/notifier/product_notifier.dart';
import 'package:my_stock/screens/product_out.dart';

import 'product_in_screen.dart';

class SaleScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    String endPoint = "/get_products.php";
    var notifier = useProvider(productNotifier(endPoint));
    if (notifier.loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      notifier.load(endPoint);
      var productList = notifier.productsList;
      int totalInStock = 0;
      for (var product in productList) {
        int quantity = int.parse(product.quantity);
        totalInStock += quantity;
      }
      return Scaffold(
        appBar: MyAppBar(title: 'Transactions'),
        body: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildProductTotal(
                    numOfProduct: productList.length,
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          buildMyText(text: 'In Stock: '),
                          buildMyText(text: 'Sold Out: '),
                          buildMyText(text: 'In Hand: '),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildMyText(text: '$totalInStock'),
                          buildMyText(text: '${notifier.totalQuantityOut}'),
                          buildMyText(text: '$totalInStock'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 34,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  buildButton(
                    title: 'Products In',
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => ProductInScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  buildButton(
                    title: 'Product Out',
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => ProductOutScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Expanded buildButton({
    String title,
    Function onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Container buildProductTotal({
    int numOfProduct,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Products:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '$numOfProduct',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Row buildMyText({
    String text,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
