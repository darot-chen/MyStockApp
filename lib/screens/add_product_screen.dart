import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/components/my_dropdown.dart';
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
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();

  TextEditingController etCategory = new TextEditingController();
  TextEditingController etProductName = new TextEditingController();
  TextEditingController etStock = new TextEditingController();
  TextEditingController etPrice = new TextEditingController();
  TextEditingController etDescript = new TextEditingController();
  TextEditingController etProductPhoto = new TextEditingController();
  TextEditingController etImportDate = new TextEditingController();

  DateTime _date = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1999),
      lastDate: DateTime(2050),
      textDirection: TextDirection.ltr,
      initialDatePickerMode: DatePickerMode.year, 
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
      appBar: MyAppBar(title: 'New Product'),
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
                hintStyle: TextStyle(color: Color(0xFF000000)),
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
                hintStyle: TextStyle(color: Color(0xFF000000)),
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
                hintStyle: TextStyle(color: Color(0xFF000000)),
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
                hintStyle: TextStyle(color: Color(0xFF000000)),
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

  // get _buildProductPhoto {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Container(
  //           alignment: Alignment.topLeft,
  //           child: Text(
  //             'Product Photo',
  //             style: TextStyle(
  //               color: Color(0xFF243859),
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 9,
  //         ),
  //         Container(
  //           child: TextFormField(
  //             controller: etProductPhoto,
  //             validator: (value) {
  //               if (value == null || value.isEmpty) {
  //                 return 'Please enter some text';
  //               }
  //               return null;
  //             },
  //             autocorrect: true,
  //             decoration: InputDecoration(
  //               fillColor: Color(0xFFE1E1E1),
  //               filled: true,
  //               hintText: "",
  //               hintStyle: TextStyle(color: Color(0xFF000000)),
  //               prefixIcon: IconButton(
  //                   icon: Icon(
  //                     Icons.add_a_photo_rounded,
  //                     size: 25,
  //                     color: Color(0xFF243859),
  //                   ),
  //                   onPressed: () {}),
  //               border: InputBorder.none,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
              controller: etImportDate,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter date';
                }
                return null;
              },
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFE1E1E1),
                filled: true,
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
          if (_formKey.currentState.validate()) _sendText(context);
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

  void _sendText(BuildContext context) {
    String nCategory = etCategory.text;
    String nProductName = etProductName.text;
    String nStock = etStock.text;
    String nPrice = etPrice.text;
    String nDescript = etDescript.text;
    String nProductPhoto = etProductPhoto.text;
    String nImportDtae = etImportDate.text;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          nCategoryText: nCategory,
          nProductNameText: nProductName,
          nStockText: nStock,
          nPriceText: nPrice,
          nDescriptText: nDescript,
          nProductPhotoText: nProductPhoto,
          nImportDateText: nImportDtae,
        ),
      ),
    );
  }
}
