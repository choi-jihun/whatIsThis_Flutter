import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatisthis/di/providers.dart';
import 'package:whatisthis/state/dictionary_state.dart';

part 'dictionary_view_model.g.dart';

@riverpod
class DictionaryViewModel extends AutoDisposeAsyncNotifier<DictionaryState> {
  @override
  Future<DictionaryState> build() async {
    try {
      final userId = ref.read(authRepositoryProvider).currentUser!.id;
      final allSpecies =
          await ref.read(speciesRepositoryProvider).getAllSpecies();
      final discoveredSpecies = await ref
          .read(speciesRepositoryProvider)
          .getDiscoveredSpecies(userId);
      final discoveredSpeciesIds = discoveredSpecies.map((s) => s.id).toList();

      final discoveryRate = allSpecies.isNotEmpty
          ? discoveredSpecies.length / allSpecies.length
          : 0.0;

      return DictionarySuccess(
        species: allSpecies,
        discoveredSpeciesIds: discoveredSpeciesIds,
        discoveryRate: discoveryRate,
      );
    } catch (e) {
      return DictionaryError(e.toString());
    }
  }
}
