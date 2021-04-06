import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/components/my_dropdown.dart';
import 'package:my_stock/screens/product_detail_screen.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AddProductPage extends HookWidget {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();

  TextEditingController etCategory = TextEditingController();
  TextEditingController etProductName = TextEditingController();
  TextEditingController etStock = TextEditingController();
  TextEditingController etPrice = TextEditingController();
  TextEditingController etDescript = TextEditingController();
  CalendarController calendarController = CalendarController();

  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: MyAppBar(title: 'New Product'),
        body: _buildBody(context),
      ),
    );
  }

  Form _buildBody(BuildContext context) {
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
            buildCarlendar(),
            SizedBox(
              height: 40,
            ),
            _buildButtonAdd(context),
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
              // items: ['Drinks', 'Snacks', 'Clothes'],
              onChanged: (value) {},
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product name';
                }
                return null;
              },
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "",
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter stock';
                }
                return null;
              },
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "",
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter price';
                }
                return null;
              },
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "",
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter descript';
                }
                return null;
              },
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
                hintText: "",
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

  Container buildCarlendar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: SfCalendar(
        controller: calendarController,
        backgroundColor: Colors.transparent,
        initialSelectedDate: DateTime.now(),
        view: CalendarView.month,
        showDatePickerButton: true,
        showNavigationArrow: true,
        monthViewSettings: MonthViewSettings(
          showTrailingAndLeadingDates: false,
        ),
      ),
    );
  }

  Container _buildButtonAdd(BuildContext context) {
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
