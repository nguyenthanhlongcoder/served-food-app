class ProductRankingModel {
  int id;
  int qty;
  String name;
  int totalSale;

  ProductRankingModel({int id, String name, int totalSale, int qty}) {
    this.id = id;
    this.name = name;
    this.totalSale = totalSale;
    this.qty = qty;
  }
}
