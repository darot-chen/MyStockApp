import 'package:flutter/material.dart';
import 'package:my_stock/components/my_app_bar.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Account'),
    );
  }
}