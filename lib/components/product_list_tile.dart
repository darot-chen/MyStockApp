import 'package:flutter/material.dart';
import 'package:my_stock/models/product_models.dart';
import 'package:my_stock/screens/product_detail_screen.dart';

import 'date_helper.dart';

class MyProductListTile extends StatelessWidget {
  const MyProductListTile({
    Key key,
    this.product,
    this.trailingTitle,
  }) : super(key: key);

  final Product product;
  final String trailingTitle;

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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product,),
            ),
          );
        },
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
        title: Row(
          children: [
            Text(
              product.name + ' - ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              product.catId[0].name,
              style: TextStyle(backgroundColor: Colors.red[100]),
            )
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#${product.id} - ${dateHelper(product.createDate)}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              product.desc ?? "",
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
              '${product.quantity}',
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
