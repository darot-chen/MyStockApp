import 'package:flutter/material.dart';
import 'package:my_stock/components/my_app_bar.dart';

import 'product_in_screen.dart';

class SaleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                buildProductTotal(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildMyText(text: 'In: '),
                    buildMyText(text: 'Out: '),
                    buildMyText(text: 'In Hand: '),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildMyText(text: '100'),
                    buildMyText(text: '20'),
                    buildMyText(text: '80'),
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
                    print('Product Out tapped');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  Expanded buildProductTotal() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            '30',
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
