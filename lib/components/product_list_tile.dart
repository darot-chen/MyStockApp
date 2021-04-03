import 'package:flutter/material.dart';

class MyProductListTile extends StatelessWidget {
  const MyProductListTile({
    Key key,
    @required this.id,
    @required this.title,
    @required this.date,
    @required this.subTitle,
    @required this.numOfStock,
    @required this.trailingTitle,
  }) : super(key: key);

  final String date;
  final String title;
  final String id;
  final String subTitle;
  final String trailingTitle;
  final int numOfStock;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        tileColor: Colors.blueGrey,
        isThreeLine: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: Container(
          height: 54,
          width: 54,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage('assets/images/box.png'),
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$id - $date',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              subTitle,
              style: TextStyle(color: Colors.white54),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              trailingTitle,
              style: TextStyle(color: Colors.white60),
            ),
            Text(
              '$numOfStock',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
