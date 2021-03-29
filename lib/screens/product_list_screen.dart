import 'package:flutter/material.dart';
import 'package:my_stock/components/build_action_btn.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/components/product_list_tile.dart';
import 'package:my_stock/components/show_bottom_sheet.dart';
import 'package:my_stock/databases/products_data.dart';

class ProductListScreen extends StatelessWidget {
  final String title;

  const ProductListScreen({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: title,
        action: [
          buildActionBtn(icon: Icons.search),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: buildActionBtn(
              icon: Icons.filter_list,
              onTap: () {
                displayBottomSheet(context);
              },
            ),
          ),
        ],
      ),
      body: ListView(
        children: List.generate(
          products.length,
          (index) {
            var product = products[index];
            DateFormat formater = DateFormat('dd/MMM/yyy');
            String date = formater.format(product.date);
            return Container(
              margin: EdgeInsets.all(5),
              child: MyProductListTile(
                date: date,
                image: product.image,
                title: product.name,
                id: product.id,
                subTitle: product.desc,
                numOfStock: product.numOfStock,
                trailingTitle: 'In Stock',
              ),
            );
          },
        ),
      ),
    );
  }
}
