import 'package:flutter/material.dart';
import 'package:my_stock/components/my_app_bar.dart';

class ProductDetailPage extends StatelessWidget {
  final String nCategoryText;
  final String nProductNameText;
  final String nStockText;
  final String nPriceText;
  final String nDescriptText;
  final String nProductPhotoText;
  final String nImportDateText;
  ProductDetailPage(
      {Key key,
      @required this.nStockText,
      this.nCategoryText,
      this.nProductNameText,
      this.nDescriptText,
      this.nProductPhotoText,
      this.nImportDateText,
      this.nPriceText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: nProductNameText,
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
              nDescriptText,
              style: TextStyle(fontSize: 12),
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
            Text("Stock"),
            Text(nStockText),
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
            Text("Price"),
            Text(nPriceText),
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
            Text("Date"),
            Text(nImportDateText),
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
        onPressed: () {},
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
