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
}
