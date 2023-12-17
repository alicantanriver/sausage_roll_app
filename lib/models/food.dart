class Food {
  final String name;
  final String description;
  final double eatOutPrice;
  final double eatInPrice;
  final String image;
  final List availableTimes;

  Food({
    required this.name,
    required this.description,
    required this.eatOutPrice,
    required this.eatInPrice,
    required this.image,
    required this.availableTimes,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        name: json['articleName'],
        description: json['customerDescription'],
        eatOutPrice: json['eatOutPrice'],
        eatInPrice: json['eatInPrice'],
        image: json['thumbnailUri'],
        availableTimes: json['dayParts']);
  }
}
