class Product {
  String id;
  String name;
  DateTime date;
  String desc;
  String image;
  int numOfStock;

  Product({
    this.id,
    this.name,
    this.date,
    this.desc,
    this.image,
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
          image: 'assets/images/coca.png'),
      Product(
        id: '#2021002',
        name: 'Pepsi#1',
        date: DateTime.now(),
        desc: 'Caca buy from someone with low price',
        numOfStock: 40,
        image: 'assets/images/pepsi.png',
      ),
      Product(
        id: '#2021003',
        name: 'Samurai',
        date: DateTime.now(),
        desc: 'Caca buy from someone with low price',
        numOfStock: 100,
        image: 'assets/images/samurai.png',
      ),
      Product(
        id: '#2021004',
        name: 'Oishi',
        date: DateTime.now(),
        desc: 'Caca buy from someone with low price',
        numOfStock: 30,
        image: 'assets/images/oishi.png',
      ),
    ];
  }
}
