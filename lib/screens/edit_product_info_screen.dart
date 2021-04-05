import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/components/my_dropdown.dart';
import 'package:my_stock/screens/product_detail_screen.dart';

class EditProductInfo extends StatefulWidget {
  final String name;
  final String numOfStock;
  final String price;
  final String desc;
  final String date;
  EditProductInfo(
      {Key key,
      @required this.name,
      this.numOfStock,
      this.price,
      this.desc,
      this.date})
      : super(key: key);
  @override
  _EditProductInfoState createState() => _EditProductInfoState();
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

class _EditProductInfoState extends State<EditProductInfo> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();

  TextEditingController etCategory = new TextEditingController();
  TextEditingController etProductName = new TextEditingController();
  TextEditingController etStock = new TextEditingController();
  TextEditingController etPrice = new TextEditingController();
  TextEditingController etDescript = new TextEditingController();

  DateTime _date = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1999),
      lastDate: DateTime(2050),
      // textDirection: TextDirection.ltr,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: (DateTime val) =>
          val.weekday == 6 || val.weekday == 7 ? false : true,
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
      key: _scaffoldKey,
      appBar: MyAppBar(title: 'Edit Product'),
      body: _buildBody,
    );
  }

  get _buildBody {
    return Form(
      key: _formKey,
      child: Container(
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
            _buildDescript,
            SizedBox(
              height: 10,
            ),
            _buildImportDate,
            SizedBox(
              height: 40,
            ),
            _buildButtonAdd,
          ],
        ),
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
            alignment: Alignment.center,
            child: MyDropDown(
              height: 48,
              items: ['Drinks', 'Snacks', 'Clothes'],
              onChanged: (value) {
                setState(() {});
              },
              hintText: Text('Category'),
              icon: Icon(Icons.arrow_drop_down_circle),
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
            child: TextFormField(
              controller: etProductName,
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: widget.name,
                hintStyle: TextStyle(color: Color(0xFF4B5B75)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
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
            width: 170,
            child: TextFormField(
              controller: etStock,
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: widget.numOfStock,
                hintStyle: TextStyle(color: Color(0xFF4B5B75)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
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
            width: 170,
            child: TextFormField(
              controller: etPrice,
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: widget.price,
                hintStyle: TextStyle(color: Color(0xFF4B5B75)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
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
            child: TextFormField(
              controller: etDescript,
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: widget.desc,
                hintStyle: TextStyle(color: Color(0xFF4B5B75)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
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
            child: TextFormField(
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: widget.date,
                hintStyle: TextStyle(color: Color(0xFF4B5B75)),
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  _selectDate(context);
                });
              },
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
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _sendText(context);
            _clear(context);
          }
        },
        child: Text(
          "Save Product",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _clear(BuildContext context) {
    etCategory.clear();
    etProductName.clear();
    etStock.clear();
    etPrice.clear();
    etDescript.clear();
  }

  void _sendText(BuildContext context) {
    DateFormat formater = DateFormat('dd/MMM/yyy');
    String date = formater.format(DateTime.now());
    String nProductName = etProductName.text;
    String nStock = etStock.text;
    String nPrice = etPrice.text; 
    String nDescript = etDescript.text;
    String nImportDate = date;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          name: nProductName,
          desc: nDescript,
          numOfStock: nStock,
          price: nPrice,
          date: nImportDate, 
        ),
      ),
    );
  }
}
