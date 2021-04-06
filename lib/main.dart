import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_stock/screens/tset_api_screen.dart';
import 'screens/navigation_bar.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const MaterialColor textColor = MaterialColor(0xFFE53C49, <int, Color>{
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: textColor,
      ),
      // home: TestApiScreen(),
      home: NavigationTabBar(),
    );
  }
}
