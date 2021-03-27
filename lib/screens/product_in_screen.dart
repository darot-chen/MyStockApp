import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/components/product_list_tile.dart';
import 'package:my_stock/databases/products_data.dart';

class ProductInScreen extends StatefulWidget {
  @override
  _ProductInScreenState createState() => _ProductInScreenState();
}

class _ProductInScreenState extends State<ProductInScreen> {
  String text;
  TextEditingController quantiryController = TextEditingController();
  TextEditingController lifeStatusController = TextEditingController();
  bool isValidate = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    text = 'Choose Product';
    isValidate = true;
    super.initState();
  }

  @override
  void dispose() {
    quantiryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Product In'),
      body: Column(
        children: [
          chooseProductBtn(context),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildMyForm(
                      labelTitle: 'Quantity',
                      message: 'Please input number',
                      controller: quantiryController,
                      keyBoardType: TextInputType.number,
                    ),
                    buildMyForm(
                      controller: lifeStatusController,
                      labelTitle: 'Life Status',
                      message: 'Please input number',
                      keyBoardType: TextInputType.text,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    print(_formKey.currentState.validate());
                    setState(() {
                      isValidate = _formKey.currentState.validate();
                    });
                    if (_formKey.currentState.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildMyForm({
    String labelTitle,
    String message,
    TextInputType keyBoardType,
    TextEditingController controller,
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
            maxLines: 1,
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

  InkWell chooseProductBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        _showBottomSheet(context);
      },
      child: Container(
        height: 42,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFF4B5B75),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
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
                        child: ListView.builder(
                          controller: controller,
                          itemCount: products.length,
                          itemBuilder: (_, index) {
                            var product = products[index];
                            DateFormat formater = DateFormat('dd/MMM/yyy');
                            String date = formater.format(product.date);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 5,
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    text = product.name;
                                  });
                                  // print(product.name);
                                  Navigator.of(context).pop();
                                },
                                child: MyProductListTile(
                                  date: date,
                                  image: product.image,
                                  title: product.name,
                                  id: product.id,
                                  subTitle: product.desc,
                                  numOfStock: product.numOfStock,
                                  trailingTitle: 'In Stock',
                                ),
                              ),
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
}
