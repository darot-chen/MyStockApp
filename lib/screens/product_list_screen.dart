import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_stock/components/build_action_btn.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/components/product_list_tile.dart';
import 'package:my_stock/components/show_bottom_sheet.dart';
import 'package:my_stock/models/product_model.dart';
import 'package:my_stock/notifier/product_notifier.dart';

class ProductListScreen extends StatelessWidget {
  final String title;

  const ProductListScreen({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Null> _refresh() async {
      await Future.delayed(Duration(seconds: 3)).then(
        (value) {
          ProductNotifier().load();
          print('refresh');
        },
      );
    }

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
      body: Consumer(
        builder: (context, watch, child) {
          final _notifier = watch(productNotifier);

          final _productNotNull = _notifier.productsList != null;
          if (_productNotNull) {
            var listProduct = _notifier.productsList;
            listProduct.sort((a, b) => a.id.compareTo(b.id));
            return RefreshIndicator(
              child: buildProductList(
                context: context,
                productList: listProduct,
                isLoading: _notifier.loading,
              ),
              onRefresh: _refresh,
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
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
    );
  }
}
