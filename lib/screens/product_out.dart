import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/components/product_list_tile.dart';
import 'package:my_stock/models/product_model.dart';
import 'package:my_stock/notifier/product_notifier.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ProductOutScreen extends HookWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController quantiryController = TextEditingController();
  CalendarController calendarController = CalendarController();

  int _quantity;

  @override
  Widget build(BuildContext context) {
    var notifier = useProvider(productNotifier('/get_products.php'));
    var choosedProduct = notifier.choosedProduct;
    _saveForm() {
      var form = _formKey.currentState;
      if (choosedProduct != null) {
        notifier.setIsValidate(
          _formKey.currentState.validate(),
        );
        if (form.validate()) {
          form.save();
          // choosedProduct.quantity -= _quantity;
          choosedProduct.createDate = calendarController.selectedDate;
          // notifier.updateTotalQuantityOut(_quantity);
          notifier.updateProduct(choosedProduct);
          notifier.choosedProduct = null;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Stock Updated'),
            ),
          );
          Navigator.pop(context);
        }
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
        resizeToAvoidBottomInset: false,
        appBar: MyAppBar(title: 'Product Out'),
        body: Column(
          children: [
            chooseProductBtn(
              context: context,
              // choosedProduct: notifier.choosedProduct,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      addQuantity(
                        isValidate: notifier.isValidate,
                        labelTitle: 'Quantity Out',
                        message: 'Please input number',
                        controller: quantiryController,
                        keyBoardType: TextInputType.number,
                      ),
                      currentQuantity(
                        currentQuantity: notifier.choosedProduct != null
                            ? '${notifier.choosedProduct.quantity}'
                            : '',
                      ),
                    ],
                  ),
                  buildCarlendar(),
                  if (notifier.choosedProduct != null)
                    buildSubmitBtn(onPressed: _saveForm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column currentQuantity({String currentQuantity}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Current Quantity",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF4B5B75),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 36,
          width: 170,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFFE1E1E1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(currentQuantity),
        ),
      ],
    );
  }

  TextButton buildSubmitBtn({Function onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red,
        ),
        child: Text(
          'Submit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Container buildCarlendar() {
    return Container(
      margin: EdgeInsets.all(15),
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

  Column addQuantity({
    String labelTitle,
    String message,
    TextInputType keyBoardType,
    TextEditingController controller,
    bool isValidate,
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
          height: isValidate ? 36 : 58,
          width: 170,
          alignment: Alignment.center,
          child: TextFormField(
            controller: controller,
            cursorColor: Color(0xFF4B5B75),
            maxLines: 1,
            textAlign: TextAlign.center,
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
            onSaved: (value) {
              _quantity = int.parse(value);
            },
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

  InkWell chooseProductBtn({
    BuildContext context,
    Product choosedProduct,
  }) {
    return InkWell(
      onTap: () {
        showProductBottomSheet(
          context: context,
        );
      },
      child: Container(
        height: 48,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: choosedProduct != null ? Color(0xFF4B5B75) : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          choosedProduct != null
              ? '${choosedProduct.name} - ${choosedProduct.id}'
              : 'Choose Product',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void showProductBottomSheet({
    BuildContext context,
    Function(String) onTap,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Colors.transparent,
            child: DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.2,
              maxChildSize: 0.75,
              builder: (_, controller) {
                DateFormat formater = DateFormat('dd/MMM/yyy');
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.remove,
                        color: Colors.grey[600],
                      ),
                      Expanded(
                        child: Consumer(
                          builder: (context, watch, child) {
                            var _notifier = watch(productNotifier('/get_products.php'));
                            var listProduct = _notifier.productsList;
                            listProduct.sort((a, b) => a.id.compareTo(b.id));
                            if (listProduct == null)
                              return CircularProgressIndicator();
                            else
                              return ListView.builder(
                                controller: controller,
                                itemCount: listProduct.length,
                                itemBuilder: (_, index) {
                                  var product = listProduct[index];
                                  String date = formater.format(product.createDate);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 5,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        _notifier.chooseProduct(product);
                                        Navigator.of(context).pop();
                                      },
                                      child: MyProductListTile(
                                        date: date,
                                        name: product.name,
                                        id: product.id,
                                        subTitle: product.desc,
                                        numOfStock: product.quantity,
                                        trailingTitle: 'In Stock',
                                      ),
                                    ),
                                  );
                                },
                              );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // DropdownButtonFormField<String> myDropDrown({
  //   List<String> items,
  //   double height,
  //   Widget hintText,
  //   Widget icon,
  // }) {
  //   return DropdownButtonFormField<String>(
  //     itemHeight: height,
  //     value: _lifeStatus,
  //     items: items
  //         .map(
  //           (label) => DropdownMenuItem(
  //             child: Text(
  //               label.toString(),
  //             ),
  //             value: label,
  //           ),
  //         )
  //         .toList(),
  //     hint: hintText,
  //     icon: icon,
  //     onChanged: (value) {
  //       _lifeStatus = value;
  //     },
  //     decoration: InputDecoration(
  //       fillColor: Color(0xFFE1E1E1),
  //       filled: true,
  //       isDense: true,
  //       hintStyle: TextStyle(color: Color(0xFF4B5B75)),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(4),
  //         borderSide: BorderSide(
  //           width: 0,
  //           style: BorderStyle.none,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
