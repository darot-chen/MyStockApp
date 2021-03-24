import 'package:flutter/material.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/screens/product_detail_screen.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

const MaterialColor _buttonTextColor = MaterialColor(0xFFE53C49, <int, Color>{
  50: Color(0xFFE53C49),
  100: Color(0xFFE53C49),
  200: Color(0xFFE53C49),
  300: Color(0xFFE53C49),
  400: Color(0xFFE53C49),
  500: Color(0xFFE53C49),
  600: Color(0xFFE53C49),
  700: Color(0xFFE53C49),
  800: Color(0xFFE53C49),
  900: Color(0xFFE53C49),
});

class _AddProductPageState extends State<AddProductPage> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1999),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            primarySwatch: _buttonTextColor,
            primaryColor: Color(0xFFE53C49),
            accentColor: Color(0xFFE53C49),
          ),
          child: child,
        );
      },
    );
    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        print(
          _date.toString(),
        );
      });
    }
  }

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
          SizedBox(
            height: 10,
          ),
          _buildProductName,
          SizedBox(
            height: 10,
          ),
          _buildQuantities,
          SizedBox(
            height: 10,
          ),
          _buildSizes,
          SizedBox(
            height: 10,
          ),
          _buildDescript,
          SizedBox(
            height: 10,
          ),
          _buildProductPhoto,
          SizedBox(
            height: 10,
          ),
          _buildImportDate,
          SizedBox(
            height: 20,
          ),
          _buildButtonAdd,
        ],
      ),
    );
  }

  get _buildCategory {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Category',
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Container(
            height: 36,
            child: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "Drinks, Snacks, clothes .....",
                hintStyle: TextStyle(color: Color(0xFF000000)),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      size: 24,
                      color: Color(0xFF243859),
                    ),
                    onPressed: () {}),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _buildProductName {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Product Name',
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Container(
            height: 36,
            child: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "",
                hintStyle: TextStyle(color: Color(0xFF000000)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _buildQuantities {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuantity,
          _buildPrice,
        ],
      ),
    );
  }

  get _buildQuantity {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(
              'Quantities',
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Container(
            height: 36,
            width: 170,
            child: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "",
                hintStyle: TextStyle(color: Color(0xFF000000)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _buildPrice {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              'Price',
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Container(
            height: 36,
            width: 90,
            child: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "",
                hintStyle: TextStyle(color: Color(0xFF000000)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _buildSizes {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSize,
          _buildLiftStatus,
        ],
      ),
    );
  }

  get _buildSize {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Size',
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Container(
            height: 36,
            width: 170,
            child: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "None",
                hintStyle: TextStyle(color: Color(0xFF000000)),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      size: 24,
                      color: Color(0xFF243859),
                    ),
                    onPressed: () {}),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _buildLiftStatus {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Lift Status',
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Container(
            height: 36,
            width: 170,
            child: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "None",
                hintStyle: TextStyle(color: Color(0xFF000000)),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      size: 24,
                      color: Color(0xFF243859),
                    ),
                    onPressed: () {}),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _buildDescript {
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
          SizedBox(
            height: 9,
          ),
          Container(
            child: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "",
                hintStyle: TextStyle(color: Color(0xFF000000)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _buildProductPhoto {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Product Photo',
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Container(
            child: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "",
                hintStyle: TextStyle(color: Color(0xFF000000)),
                prefixIcon: IconButton(
                    icon: Icon(
                      Icons.add_a_photo_rounded,
                      size: 25,
                      color: Color(0xFF243859),
                    ),
                    onPressed: () {}),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _buildImportDate {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Import Date',
              style: TextStyle(
                color: Color(0xFF243859),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Container(
            child: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "",
                hintStyle: TextStyle(color: Color(0xFF000000)),
                prefixIcon: IconButton(
                    icon: Icon(
                      Icons.date_range_rounded,
                      size: 25,
                      color: Color(0xFF243859),
                    ),
                    onPressed: () {
                      setState(() {
                        _selectDate(context);
                      });
                    }),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _buildButtonAdd {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFFE53C49),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Add Product",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
