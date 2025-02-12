import 'package:whatisthis/model/species.dart';

abstract class SpeciesRepository {
  Future<List<Species>> getSeasonalSpecies(String season);
  Future<List<Species>> getAllSpecies();
  Future<List<Species>> getDiscoveredSpecies(String userId);
  Future<List<Species>> getUndiscoveredSpecies(String userId);
}
