class PopularPark {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;

  PopularPark({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
  });

  factory PopularPark.fromJson(Map<String, dynamic> json) {
    print('PopularPark fromJson: $json');
    try {
      return PopularPark(
        id: json['park_id'].toString(),
        name: json['park_name'].toString(),
        description: json['description'].toString(),
        imageUrl: json['image_url']?.toString(),
      );
    } catch (e) {
      print('Error in PopularPark.fromJson: $e');
      rethrow;
    }
  }
}
