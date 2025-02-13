import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatisthis/model/species.dart';
import 'package:whatisthis/repository/species_repository.dart';

class SpeciesRepositoryImpl implements SpeciesRepository {
  final SupabaseClient _supabaseClient;

  SpeciesRepositoryImpl(this._supabaseClient);

  @override
  Future<List<Species>> getSeasonalSpecies(String season) async {
    try {
      print('Requesting seasonal species for season: $season');
      final response = await _supabaseClient
          .from('species_seasons')
          .select('*, species(*)')
          .eq('season', season.toUpperCase())
          .limit(5);

      print('Seasonal Species Response: $response');
      return response
          .map((json) => Species(
                id: json['species']['species_id'],
                name: json['species']['name'],
                imageUrl: json['species']['image_url'],
                season: json['season'],
              ))
          .toList();
    } catch (e) {
      print('Error getting seasonal species: $e');
      rethrow;
    }
  }

  @override
  Future<List<Species>> getAllSpecies() async {
    try {
      print('Requesting all species');
      final response =
          await _supabaseClient.from('species').select('*').order('name');

      print('All Species Response: $response');
      return response.map((json) => Species.fromJson(json)).toList();
    } catch (e) {
      print('Error getting all species: $e');
      rethrow;
    }
  }

  @override
  Future<List<Species>> getDiscoveredSpecies(String userId) async {
    try {
      print('Requesting discovered species for user: $userId');
      final response = await _supabaseClient
          .from('species')
          .select('*, discoveries!inner(*)')
          .eq('discoveries.user_id', userId)
          .order('name');

      print('Discovered Species Response: $response');
      return response.map((json) => Species.fromJson(json)).toList();
    } catch (e) {
      print('Error getting discovered species: $e');
      rethrow;
    }
  }

  @override
  Future<List<Species>> getUndiscoveredSpecies(String userId) async {
    try {
      print('Requesting undiscovered species for user: $userId');
      final response = await _supabaseClient
          .from('species')
          .select('*, discoveries(*)')
          .not('discoveries', 'cs', '{"user_id": "$userId"}')
          .order('name');

      print('Undiscovered Species Response: $response');
      return response.map((json) => Species.fromJson(json)).toList();
    } catch (e) {
      print('Error getting undiscovered species: $e');
      rethrow;
    }
  }

  @override
  Future<Species> getSpeciesDetail(String speciesId) async {
    try {
      final response = await _supabaseClient
          .from('species')
          .select()
          .eq('species_id', speciesId)
          .single();

      return Species.fromJson(response);
    } catch (e) {
      print('Error getting species detail: $e');
      rethrow;
    }
  }
}
