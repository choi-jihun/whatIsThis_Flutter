class Species {
  final String id;
  final String name;
  final String? imageUrl;
  final String season;

  Species({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.season,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      id: json['species_id'],
      name: json['name'],
      imageUrl: json['image_url'],
      season: json['season'],
    );
  }
}
