import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/screens/edit_product_info_screen.dart';

class ProductDetailPage extends StatefulWidget {
  final String name;
  final String numOfStock;
  final String price;
  final String desc;
  final String date;
  ProductDetailPage(
      {Key key,
      @required this.name,
      this.numOfStock,
      this.price,
      this.desc,
      this.date})
      : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.name,
        action: [
          IconButton(
            icon: Icon(Icons.delete_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildBody,
    );
  }

  get _buildBody {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildDescription,
          SizedBox(
            height: 20,
          ),
          _buildStock,
          SizedBox(
            height: 10,
          ),
          _buildPrice,
          SizedBox(
            height: 10,
          ),
          _buildImportDate,
          SizedBox(
            height: 40,
          ),
          _buildAddMoreStock,
          SizedBox(
            height: 20,
          ),
          _buildEditinfo,
        ],
      ),
    );
  }

  get _buildDescription {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Descriptions',
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              widget.desc,
              style: TextStyle(
                color: Color(0xFF4B5B75),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _buildStock {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE53C49)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Stock",
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.numOfStock,
              style: TextStyle(
                color: Color(0xFF4B5B75),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  get _buildPrice {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE53C49)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Price",
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.price,
              style: TextStyle(
                color: Color(0xFF4B5B75),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  get _buildImportDate {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE53C49)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Date",
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.date,
              style: TextStyle(
                color: Color(0xFF4B5B75),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  get _buildAddMoreStock {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFFE53C49),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Add More Stock",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  get _buildEditinfo {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE53C49)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditProductInfo(
                name: widget.name,
                desc: widget.desc,
                numOfStock: widget.numOfStock,
                price: widget.price,
                date: widget.date,

              ),
            ),
          );
        },
        child: Text(
          "Edit information",
          style: TextStyle(
            color: Color(0xFFE53C49),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
