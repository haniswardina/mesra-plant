class Plant {
  final String name;
  final String image;
  final double ph;
  final double moisture;
  final double potSize;
  final String type; // Succulent, Tropical, Flowering

  Plant({
    required this.name,
    required this.image,
    required this.ph,
    required this.moisture,
    required this.potSize,
    required this.type,
  });
}