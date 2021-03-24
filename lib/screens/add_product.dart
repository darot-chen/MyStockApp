import 'package:flutter/material.dart';
import 'package:my_stock/components/my_app_bar.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'New Product'),
      body: _buildBody,
    );
  }

  get _buildBody {
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: [
          _buildCategory,
          SizedBox(height: 15,),
          _buildcat,
        ],
      ),
    );
  }

  get _buildCategory {
    return Container(
      child: Text(
        'Category',
        style: TextStyle(
          color: Color(0xFF243859),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  get _buildcat{
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE1E1E1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Color(0xFFE1E1E1)),
          ),
          border: OutlineInputBorder(),
          hintText: "Drinks, Snacks, clothes .....",
          hintStyle: TextStyle(color: Color(0xFF000000),),
        ),
      ),
    );
  }
}
