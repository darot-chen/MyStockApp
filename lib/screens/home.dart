import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/models/categories_model.dart';
import 'package:my_stock/notifier/categories_notifier.dart';
import 'package:my_stock/notifier/product_notifier.dart';
import 'package:my_stock/screens/product_list_screen.dart';

class Home extends HookWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var notifier = useProvider(categoryNotifier);
    String catName;
    if (notifier.loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      var categories = notifier.categories;
      // notifier.load();
      return Scaffold(
        appBar: MyAppBar(title: "MyStock", backIcon: false),
        body: RefreshIndicator(
          onRefresh: () {
            return notifier.load();
          },
          child: GridView(
            padding: EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 155 / 100,
            ),
            children: List.generate(
              categories.length + 1,
              (index) {
                if (index == categories.length) {
                  return catCard(
                    context: context,
                    catName: 'All Products',
                    isLastIndex: true,
                  );
                }
                return catCard(
                  context: context,
                  catName: categories[index].name,
                  catId: categories[index].id,
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => alertDialog(
                title: 'New Category',
                rButtonText: 'OK',
                hintText: 'Category Name',
                catName: catName,
                context: context,
                onSaved: (value) {
                  catName = value;
                },
                onChanged: (String value) {
                  notifier.setCatExist(false);
                  for (var item in categories) {
                    if (item.name.toLowerCase() == value.toLowerCase()) {
                      notifier.setCatExist(true);
                    }
                  }
                },
                onPressed: () {
                  var form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    notifier.isCatExist
                        ? showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("Product Exist false"),
                            ),
                          )
                        : notifier.categoryPostRequest(
                            endPoint: '/create_category.php',
                            name: catName.trim(),
                          );
                    notifier.load();
                    Navigator.pop(context);
                  }
                  notifier.isCatExist
                      ? showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Create Failed"),
                            content: Text('Category is existed'),
                          ),
                        )
                      : showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Create Succeffully"),
                            content: Text('Category is created'),
                          ),
                        );
                },
              ),
            );
          },
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      );
    }
  }

  Container catCard({
    BuildContext context,
    String catName,
    String catId,
    bool isLastIndex = false,
  }) {
    var notifier = useProvider(categoryNotifier);
    var categories = notifier.categories;
    var proNotifier = useProvider(
      productNotifier("/get_product_by_cat_id.php?catId=$catId"),
    );
    var isHasProduct = proNotifier.productsList.length == 0 ||
        proNotifier.productsList == null;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onLongPress: isLastIndex
            ? null
            : () {
                !isHasProduct
                    ? showDialog(
                        context: context,
                        builder: (context) => alertDialog(
                            context: context,
                            title: 'Update',
                            rButtonText: 'Update',
                            catName: catName,
                            onSaved: (value) {
                              catName = value;
                            },
                            onChanged: (String value) {
                              notifier.setCatExist(false);
                              for (var item in categories) {
                                if (item.name.toLowerCase() ==
                                    value.toLowerCase()) {
                                  notifier.setCatExist(true);
                                }
                              }
                            },
                            onPressed: () {
                              var form = _formKey.currentState;
                              if (form.validate()) {
                                form.save();
                                notifier.isCatExist
                                    ? showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text("Product Exist false"),
                                        ),
                                      )
                                    : print(catId + catName);

                                notifier.categoryPostRequest(
                                  endPoint: '/update_category.php',
                                  id: catId,
                                  name: catName.trim(),
                                );
                                notifier.load();
                                Navigator.pop(context);
                              }
                              notifier.isCatExist
                                  ? showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text("Create Failed"),
                                        content: Text('Category is existed'),
                                      ),
                                    )
                                  : showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text("Updated"),
                                        content: Text('Category is updated'),
                                      ),
                                    );
                            }),
                      )
                    : showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          content: Wrap(
                            direction: Axis.vertical,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text('Do you want to delete '),
                                    Text(
                                      '$catName ',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Text('?'),
                                  ],
                                ),
                              ),
                              Container(
                                width: 250,
                                child: TextButton(
                                  onPressed: () {
                                    notifier.categoryPostRequest(
                                      endPoint: '/delete_category.php',
                                      id: catId,
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => ProductListScreen(
                id: catId,
                title: catName,
              ),
            ),
          );
        },
        child: Center(
          child: Text(
            catName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  AlertDialog alertDialog({
    String title,
    String catName,
    String hintText,
    String rButtonText,
    BuildContext context,
    Function onSaved,
    Function onPressed,
    Function onChanged,
  }) {
    return AlertDialog(
      title: Text(title ?? ''),
      content: Container(
        height: 100,
        child: Form(
          key: _formKey,
          child: Wrap(
            children: [
              buildInputCatName(
                hintText: hintText ?? "",
                initValue: catName ?? "",
                onSaved: onSaved,
                onChanged: onChanged,
              ),
              dialogButton(
                context: context,
                rButtonText: rButtonText ?? '',
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row dialogButton({
    String rButtonText,
    BuildContext context,
    Function onPressed,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
            style: ButtonStyle(
              side: MaterialStateProperty.all<BorderSide>(
                BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              rButtonText ?? '',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextFormField buildInputCatName({
    String initValue,
    String hintText,
    Function onSaved,
    Function onChanged,
  }) {
    return TextFormField(
      initialValue: initValue ?? "",
      cursorColor: Color(0xFF4B5B75),
      maxLines: 1,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.text,
      style: TextStyle(
        fontSize: 12,
        color: Color(0xFF4B5B75),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please input some text";
        }
        return null;
      },
      onChanged: onChanged,
      onSaved: onSaved,
      decoration: InputDecoration(
        fillColor: Color(0xFFE1E1E1),
        filled: true,
        isDense: true,
        hintText: hintText ?? '',
        hintStyle: TextStyle(color: Color(0xFF4B5B75)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
