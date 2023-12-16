class Food {
  final String name;
  final String description;
  final double eatOutPrice;
  final double eatInPrice;
  final String image;

  Food({
    required this.name,
    // required this.slug,
    required this.description,
    required this.eatOutPrice,
    required this.eatInPrice,
    required this.image,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        name: json['articleName'],
        description: json['customerDescription'],
        eatOutPrice: json['eatOutPrice'],
        eatInPrice: json['eatInPrice'],
        image: json['thumbnailUri']);
  }
}
