class FavoriteProduct {
  String category;

  String details;

  int id;

  String imageUrl;

  String name;

  int price;

  int v;

  FavoriteProduct({
    this.id,
    this.name,
    this.price,
    this.imageUrl,
    this.category,
    this.details,
    this.v,
  });

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "price": price,
        "imageUrl": imageUrl,
        "category": category,
        "details": details,
        "__v": v,
      };

  factory FavoriteProduct.fromMap(Map<String, dynamic> json) => FavoriteProduct(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        imageUrl: json["imageUrl"],
        category: json["category"],
        details: json["details"],
        v: json["__v"],
      );
}
