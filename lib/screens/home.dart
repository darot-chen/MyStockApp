import 'package:flutter/material.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/databases/categories_data.dart';
import 'package:my_stock/screens/product_list_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "MyStock"),
      body: Center(
        child: GridView(
          padding: EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 155 / 100,
          ),
          children: List.generate(
            categories.length,
            (index) {
              return catCard(index);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  Container catCard(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: categories[index].color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => ProductListScreen(
                  title: categories[index].name,
                ),
              ),
            );
          },
          child: Text(
            categories[index].name,
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
