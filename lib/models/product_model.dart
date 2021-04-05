class Product {
  String id;
  String name;
  DateTime date;
  String desc;
  int numOfStock;

  Product({
    this.id,
    this.name,
    this.date,
    this.desc,
    this.numOfStock,
  });

  static List<Product> get prodcut {
    return [
      Product(
        id: '#2021001',
        name: 'Coca Cola#1',
        date: DateTime.now(),
        desc: 'Caca buy from someone with low price',
        numOfStock: 50,
      ),
      Product(
        id: '#2021002',
        name: 'Pepsi#1',
        date: DateTime.now(),
        desc: 'Caca buy from someone with low price',
        numOfStock: 40,
      ),
      Product(
        id: '#2021003',
        name: 'Samurai',
        date: DateTime.now(),
        desc: 'Caca buy from someone with low price',
        numOfStock: 100,
      ),
      Product(
        id: '#2021004',
        name: 'Oishi',
        date: DateTime.now(),
        desc: 'Caca buy from someone with low price',
        numOfStock: 30,
      ),
    ];
  }

  static int get totalStock {
    int total = 0;
    for (var item in prodcut) {
      total += item.numOfStock;
    }
    return total;
  }
}
