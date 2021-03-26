import 'package:flutter/material.dart';

void displayBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: 200,
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Filter',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Icon(Icons.clear),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.date_range),
                      title: Text('Date'),
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      leading: Icon(Icons.inventory),
                      title: Text('Stock'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }