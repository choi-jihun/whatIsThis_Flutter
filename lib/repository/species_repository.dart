import 'package:whatisthis/model/species.dart';

abstract class SpeciesRepository {
  Future<List<Species>> getSeasonalSpecies(String season);
}
