import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatisthis/model/near_by_park.dart';
import 'package:whatisthis/model/popular_park.dart';
import 'package:whatisthis/repository/park_repository.dart';

class ParkRepositoryImpl implements ParkRepository {
  final SupabaseClient _supabaseClient;

  ParkRepositoryImpl(this._supabaseClient);

  @override
  Future<List<PopularPark>> getPopularParks() async {
    try {
      print('Requesting popular parks');
      final response = await _supabaseClient
          .from('parks')
          .select('park_id, park_name, description, image_url')
          .order('visit_count', ascending: false)
          .limit(5);

      print('Popular Parks Response: $response');
      return response.map((json) => PopularPark.fromJson(json)).toList();
    } catch (e) {
      print('Error getting popular parks: $e');
      rethrow;
    }
  }

  @override
  Future<List<NearbyPark>> getNearbyParks(double lat, double lng) async {
    try {
      print('Requesting nearby parks with lat: $lat, lng: $lng');
      final response = await _supabaseClient.rpc('get_nearby_parks',
          params: {'lat': lat, 'lng': lng, 'radius': 500000}).limit(3);

      if (response == null) return [];

      return (response as List)
          .map((json) => NearbyPark.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting nearby parks: $e');
      rethrow;
    }
  }
}
