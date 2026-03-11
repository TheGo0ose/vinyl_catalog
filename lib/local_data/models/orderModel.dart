class OrderModel {
  String nameProduct; // Здесь будет "Artist - Album"
  int countProduct;
  double sumProduct;
  String speciecLevel; // Это будет состояние (например, Mint)
  String clientAdress;

  OrderModel({
    required this.nameProduct,
    required this.countProduct,
    required this.sumProduct,
    required this.speciecLevel,
    required this.clientAdress,
  });
}