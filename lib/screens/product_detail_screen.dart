import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/models/product_models.dart';
import 'package:my_stock/notifier/product_notifier.dart';
import 'package:my_stock/screens/product_in_screen.dart';

import 'add_product.dart';

class ProductDetailPage extends HookWidget {
  final String id;
  ProductDetailPage({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String endPoint = '/get_product_by_id.php?id=$id';
    var notifier = useProvider(productNotifier(endPoint));

    if (notifier.loading)
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    else {
      notifier.load(endPoint);
      var product = notifier.productsList[0];
      return Scaffold(
        appBar: MyAppBar(
          title: product.name ?? 'Title',
          action: [
            IconButton(
              icon: Icon(Icons.delete_rounded),
              onPressed: () {
                notifier.productPostRequest(
                  endPoint: '/delete_product.php?',
                  id: product.id,
                );
                // onRefresh('/get_products.php');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product Delete Succefully'),
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return notifier.load(endPoint);
          },
          child: ListView(
            children: [
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(15),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 100 / 100,
                ),
                children: [
                  buildMyCard(
                    title: "Category",
                    value: product.catId[0].name,
                  ),
                  buildMyDateCard(product),
                  buildMyCard(
                    title: "Quantity",
                    value: product.quantity,
                  ),
                  buildMyCard(
                    title: "Price",
                    value: '${product.sellPrice}\$',
                  ),
                ],
              ),
              buildMyDivider(),
              SizedBox(height: 15),
              buildDescription(product),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.topCenter,
          height: 100,
          color: Colors.red[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: buildMyBtn(
                  color: Color(0xFF243859),
                  textColor: Colors.white,
                  title: 'Edit',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProduct(
                          product: product,
                          prevEndPoint: endPoint,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Consumer(builder: (context, watch, child) {
                  var notifier = watch(productNotifier('/get_products.php'));
                  return buildMyBtn(
                    color: Colors.white,
                    title: 'Add Quantity',
                    onTap: () {
                      notifier.chooseProduct(product);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductInScreen(),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      );
    }
  }

  TextButton buildMyBtn({
    Color color,
    Color textColor,
    String title,
    Function onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor ?? Color(0xFF243859),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Row buildMyDivider() {
    return Row(
      children: [
        Expanded(
            child: Divider(
          thickness: 1.5,
          color: Color(0xFF4B5B75),
          endIndent: 15,
        )),
        Text(
          "Description",
          style: TextStyle(
            color: Color(0xFF243859),
            fontSize: 18,
          ),
        ),
        Expanded(
            child: Divider(
          thickness: 1.5,
          color: Color(0xFF4B5B75),
          indent: 15,
        )),
      ],
    );
  }

  Container buildMyDateCard(
    Product product,
  ) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Text(
            "Create At",
            style: TextStyle(
              color: Color(0xFF243859),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Text(
            DateFormat('dd').format(product.createDate),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: Colors.white,
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            DateFormat('MMM yyyy').format(product.createDate),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Container buildMyCard({
    String title,
    double titleSize,
    String value,
    double valueSize,
  }) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        alignment: Alignment.topCenter,
        children: [
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.only(top: 15),
            alignment: Alignment.topCenter,
            child: Text(
              title ?? "Title",
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: titleSize ?? 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: Text(
              value ?? "Value",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontSize: value.length > 3 ? 40 : 64,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDescription(
    Product product,
  ) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              product.name,
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            child: Text(
              product.desc ?? 'descriptionn',
              style: TextStyle(
                color: Color(0xFF4B5B75),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
