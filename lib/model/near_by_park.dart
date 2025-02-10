class NearbyPark {
  final String id;
  final String name;
  final String? imageUrl;
  final double latitude;
  final double longitude;
  double? distance;

  NearbyPark({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.latitude,
    required this.longitude,
    this.distance,
  });

  factory NearbyPark.fromJson(Map<String, dynamic> json) {
    print('NearbyPark fromJson: $json');
    try {
      final parkPos = json['park_pos'] as Map<String, dynamic>;
      return NearbyPark(
        id: json['park_id'].toString(),
        name: json['park_name'].toString(),
        imageUrl: json['image_url']?.toString(),
        latitude: parkPos['langtitude']?.toDouble() ?? 0.0,
        longitude: parkPos['longtitude']?.toDouble() ?? 0.0,
      );
    } catch (e) {
      print('Error in NearbyPark.fromJson: $e');
      rethrow;
    }
  }
}
