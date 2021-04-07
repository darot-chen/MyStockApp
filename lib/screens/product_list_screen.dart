import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_stock/components/build_action_btn.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/components/product_list_tile.dart';
import 'package:my_stock/components/show_bottom_sheet.dart';
import 'package:my_stock/models/product_models.dart';
import 'package:my_stock/notifier/product_notifier.dart';

class ProductListScreen extends HookWidget {
  final String title;
  final String id;

  ProductListScreen({
    Key key,
    this.title,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String endPoint = id != null
        ? "/get_product_by_cat_id.php?catId=$id"
        : '/get_products.php';
    var notifier = useProvider(productNotifier(endPoint));
    var products = notifier.productsList;

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
      body: notifier.loading
          ? Center(child: CircularProgressIndicator())
          : products != null
              ? RefreshIndicator(
                  onRefresh: () {
                    return notifier.load(endPoint);
                  },
                  child: buildProductList(
                    isLoading: notifier.loading,
                    context: context,
                    productList: products,
                  ))
              : Center(
                  child: Text("No User Object"),
                ),
    );
  }

  ListView buildProductList({
    @required bool isLoading,
    @required BuildContext context,
    @required List<Product> productList,
  }) {
    return ListView(
      children: List.generate(
        productList.length,
        (index) {
          var product = productList[index];
          return Container(
            margin: EdgeInsets.all(5),
            child: MyProductListTile(
              product: product,
              trailingTitle: 'In Stock',
            ),
          );
        },
      ),
    );
  }
}
