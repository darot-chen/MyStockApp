import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/notifier/categories_notifier.dart';
import 'package:my_stock/screens/add_product.dart';
import 'package:my_stock/screens/product_list_screen.dart';

import 'add_product_screen.dart';

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var notifier = useProvider(categoryNotifier);
    var categories = notifier.categories;
    return Scaffold(
      appBar: MyAppBar(title: "MyStock"),
      body: notifier.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView(
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 155 / 100,
              ),
              children: List.generate(
                categories.length + 1,
                (index) {
                  if (index == categories.length) {
                    return catCard(context: context, catName: 'All Products');
                  }
                  return catCard(
                    context: context,
                    catName: categories[index].name,
                    catId: categories[index].id,
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => AddProduct(),
            ),
          );
        },
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  InkWell catCard({
    BuildContext context,
    String catName,
    String catId,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => ProductListScreen(
              id: catId,
              title: catName, //categories[index].name,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            catName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
