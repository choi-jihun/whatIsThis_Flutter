import 'package:whatisthis/model/species.dart';

sealed class DictionaryState {
  const DictionaryState();
}

class DictionaryInitial extends DictionaryState {}

class DictionaryLoading extends DictionaryState {}

class DictionaryError extends DictionaryState {
  final String message;
  DictionaryError(this.message);
}

class DictionarySuccess extends DictionaryState {
  final List<Species> species;
  final List<String> discoveredSpeciesIds;
  final double discoveryRate;

  DictionarySuccess({
    required this.species,
    required this.discoveredSpeciesIds,
    required this.discoveryRate,
  });
}
