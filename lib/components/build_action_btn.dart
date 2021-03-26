import 'package:flutter/material.dart';

Container buildActionBtn({
    IconData icon,
    Function onTap,
  }) {
    return Container(
      height: 30,
      width: 40,
      child: TextButton(
        onPressed: onTap,
        child: Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }