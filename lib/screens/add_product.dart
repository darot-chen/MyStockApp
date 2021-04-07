import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/components/my_dropdown.dart';
import 'package:my_stock/models/categories_model.dart';
import 'package:my_stock/models/product_models.dart';
import 'package:my_stock/notifier/categories_notifier.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:my_stock/notifier/product_notifier.dart';

import 'navigation_bar.dart';

class AddProduct extends HookWidget {
  AddProduct({this.product});
  final Product product;

  final _formKey = GlobalKey<FormState>();
  CalendarController calendarController = CalendarController();

  String catName;
  String productId;
  String productName;
  String quantity;
  String price;
  String desc;
  DateTime selectDate;

  @override
  Widget build(BuildContext context) {
    var notifier = useProvider(getProductNotifier);
    var catNotifier = useProvider(categoryNotifier);
    var categories = catNotifier.categories;

    bool isHasProduct = product != null;
    if (isHasProduct) catName = product.catId[0].name;

    _saveForm() {
      var form = _formKey.currentState;
      if (form.validate()) {
        form.save();

        notifier.productPostRequest(
          endPoint:
              isHasProduct ? '/update_product.php' : '/create_product.php',
          id: isHasProduct ? product.id : productId,
          catName: catName,
          name: productName,
          quanitity: quantity,
          sellPrice: price,
          desc: desc,
          createDate: calendarController.selectedDate.toString(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Add Product Succesfully'),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationTabBar(),
          ),
        );
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a product'),
          ),
        );
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: MyAppBar(title: 'New Product'),
        body: Stack(
          children: [
            if (notifier.loading) Center(child: CircularProgressIndicator()),
            SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    chooseCategory(
                      categories: categories,
                      isHasProduct: isHasProduct,
                      message: 'Please Choose A Category',
                      onSaved: (value) {
                        if (value != null) {
                          catName = value;
                        }
                      },
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    isHasProduct
                        ? SizedBox()
                        : myForm(
                            initialValue: isHasProduct ? product.id : '',
                            labelTitle: 'Product Id',
                            message: 'Please input number',
                            keyBoardType: TextInputType.number,
                            onSaved: (value) {
                              productId = value;
                            },
                          ),
                    myForm(
                      initialValue: isHasProduct ? product.name : "",
                      labelTitle: 'Product Name',
                      message: 'Please input number',
                      keyBoardType: TextInputType.text,
                      onSaved: (value) {
                        productName = value;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        myForm(
                          initialValue: isHasProduct ? product.quantity : '',
                          labelTitle: "Quantity",
                          message: "Please input valid number",
                          keyBoardType: TextInputType.number,
                          width: 185,
                          onSaved: (value) {
                            quantity = value;
                          },
                        ),
                        myForm(
                          initialValue: isHasProduct ? product.sellPrice : '',
                          labelTitle: "Price",
                          message: "Please input valid number",
                          keyBoardType:
                              TextInputType.numberWithOptions(decimal: true),
                          width: 185,
                          onSaved: (value) {
                            price = value;
                          },
                        ),
                      ],
                    ),
                    descForm(
                      isHasProduct: isHasProduct,
                      onSaved: (value) {
                        desc = value;
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose Date",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF4B5B75),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        buildCarlendar(isHasProduct),
                      ],
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.topCenter,
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -2),
                color: Colors.grey[300],
                blurRadius: 5,
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              _saveForm();
            },
            child: Container(
              width: double.infinity,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Add Product',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column myForm({
    String labelTitle,
    String message,
    TextInputType keyBoardType,
    String initialValue,
    String value,
    String hintText,
    double width,
    Function onSaved,
    Function onChange,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelTitle,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF4B5B75),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 58,
          width: width ?? double.infinity,
          alignment: Alignment.center,
          child: TextFormField(
            initialValue: initialValue,
            cursorColor: Color(0xFF4B5B75),
            maxLines: 1,
            textAlign: TextAlign.start,
            keyboardType: keyBoardType,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF4B5B75),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return message;
              }
              return null;
            },
            onSaved: onSaved,
            onChanged: onChange,
            decoration: InputDecoration(
              fillColor: Color(0xFFE1E1E1),
              filled: true,
              isDense: true,
              hintText: hintText ?? "",
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
    );
  }

  Container chooseCategory({
    List<Category> categories,
    bool isHasProduct,
    String message,
    Function onSaved,
    Function onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
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
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            child: MyDropDown(
              height: 48,
              items: categories,
              onSaved: onSaved,
              onChanged: onChanged,
              validator: (value) {
                if (isHasProduct) {
                  return null;
                }
                if (value == null || value.isEmpty && !isHasProduct) {
                  return message;
                }
                return null;
              },
              hintText:
                  Text(product != null ? product.catId[0].name : 'Category'),
              icon: Icon(Icons.arrow_drop_down_circle),
            ),
          ),
        ],
      ),
    );
  }

  Column descForm({
    bool isHasProduct,
    Function onSaved,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descriptions',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF4B5B75),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          width: double.infinity,
          alignment: Alignment.center,
          child: TextFormField(
            initialValue: isHasProduct ? product.desc : "",
            cursorColor: Color(0xFF4B5B75),
            maxLines: 5,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.multiline,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF4B5B75),
            ),
            onSaved: onSaved,
            decoration: InputDecoration(
              fillColor: Color(0xFFE1E1E1),
              filled: true,
              isDense: true,
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
    );
  }

  Container buildCarlendar(
    bool isHasProduct,
  ) {
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
        initialSelectedDate: isHasProduct ? product.createDate : DateTime.now(),
        view: CalendarView.month,
        showDatePickerButton: true,
        showNavigationArrow: true,
        monthViewSettings: MonthViewSettings(
          showTrailingAndLeadingDates: false,
        ),
      ),
    );
  }
}
