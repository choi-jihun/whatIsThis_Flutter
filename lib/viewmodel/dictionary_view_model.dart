import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatisthis/di/providers.dart';
import 'package:whatisthis/repository/species_repository.dart';
import 'package:whatisthis/state/dictionary_state.dart';

final dictionaryViewModelProvider =
    StateNotifierProvider<DictionaryViewModel, DictionaryState>((ref) {
  return DictionaryViewModel(
    ref.watch(speciesRepositoryProvider),
    ref.watch(authRepositoryProvider).currentUser!.id,
  );
});

class DictionaryViewModel extends StateNotifier<DictionaryState> {
  final SpeciesRepository _repository;
  final String userId;

  DictionaryViewModel(this._repository, this.userId)
      : super(DictionaryInitial());

  Future<void> loadDictionaryData() async {
    state = DictionaryLoading();
    try {
      final allSpecies = await _repository.getAllSpecies();
      final discoveredSpecies = await _repository.getDiscoveredSpecies(userId);
      final discoveredSpeciesIds = discoveredSpecies.map((s) => s.id).toList();

      final discoveryRate = allSpecies.isNotEmpty
          ? discoveredSpecies.length / allSpecies.length
          : 0.0;

      state = DictionarySuccess(
        species: allSpecies,
        discoveredSpeciesIds: discoveredSpeciesIds,
        discoveryRate: discoveryRate,
      );
    } catch (e) {
      state = DictionaryError(e.toString());
    }
  }
}
