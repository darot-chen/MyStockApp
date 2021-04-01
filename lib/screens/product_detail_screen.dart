import 'package:flutter/material.dart';
import 'package:my_stock/components/my_app_bar.dart';


class ProductDetailPage extends StatelessWidget {
  final String nCategoryText;
  final String nProductNameText;
  final String nStockText;
  final String nTakeinText;
  final String nSoldOutText;
  final String nSizeText;
  final String nDescriptText;
  final String nProductPhotoText;
  ProductDetailPage(
      {Key key,
      @required this.nStockText,
      @required this.nSizeText,
      this.nCategoryText,
      this.nProductNameText,
      this.nTakeinText,
      this.nSoldOutText,
      this.nDescriptText,
      this.nProductPhotoText})
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
          _buildImagesProduct,
          SizedBox(
            height: 30,
          ),
          _buildDescription,
          SizedBox(
            height: 20,
          ),
          _buildStocks,
          SizedBox(
            height: 10,
          ),
          _buildSizes,
          SizedBox(
            height: 10,
          ),
          _buildSale,
          SizedBox(
            height: 20,
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

  get _buildImagesProduct {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildImageDetail,
          _buildImages,
        ],
      ),
    );
  }

  get _buildImageDetail {
    return Container(
      child: Column(
        children: [
          Image.asset('assets/cocacola.jpg',
            cacheWidth: 290,
            cacheHeight: 211,
          ),
        ],
      ),
    );
  }

  get _buildImages {
    return Container(
      alignment: Alignment.topRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildImage,
          SizedBox(
            height: 10,
          ),
          _buildImage,
          SizedBox(
            height: 10,
          ),
          _buildImage,
        ],
      ),
    );
  }

  get _buildImage {
    return Container(
      child: Column(
        children: [
          Image.asset(
            'nProductPhotoText',
            cacheWidth: 50,
            cacheHeight: 50,
          ),
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

  get _buildStocks {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStock,
          _buildLifestatus,
        ],
      ),
    );
  }

  get _buildStock {
    return Container(
      width: 160,
      height: 30,
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

  get _buildLifestatus {
    return Container(
      width: 160,
      height: 30,
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
            Text("Life status"),
            Text("01/04/21"),
          ],
        ),
      ),
    );
  }

  get _buildSizes {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSize,
          _buildPrice,
        ],
      ),
    );
  }

  get _buildSize {
    return Container(
      width: 160,
      height: 30,
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
            Text("Size"),
            Text(nSizeText),
          ],
        ),
      ),
    );
  }

  get _buildPrice {
    return Container(
      width: 160,
      height: 30,
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
            Text(nTakeinText),
          ],
        ),
      ),
    );
  }

  get _buildSale {
    return Container(
      width: 360,
      height: 30,
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
            Text("Sale"),
            Text(nSoldOutText),
          ],
        ),
      ),
    );
  }

  get _buildAddMoreStock {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFFE53C49),
        borderRadius: BorderRadius.circular(17),
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
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE53C49)),
        borderRadius: BorderRadius.circular(17),
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
