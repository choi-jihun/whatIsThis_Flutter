class Species {
  final String id;
  final String name;
  final String? imageUrl;
  final String? season;
  final String? description;

  Species(
      {required this.id,
      required this.name,
      this.imageUrl,
      this.season,
      this.description});

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
        id: json['species_id'],
        name: json['name'],
        imageUrl: json['image_url'],
        season: json['season']?.toString(),
        description: json['description']?.toString());
  }
}
