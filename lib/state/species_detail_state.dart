sealed class SpeciesDetailState {
  const SpeciesDetailState();
}

class SpeciesDetailInitial extends SpeciesDetailState {}

class SpeciesDetailLoading extends SpeciesDetailState {}

class SpeciesDetailError extends SpeciesDetailState {
  final String message;
  SpeciesDetailError(this.message);
}

class SpeciesDetailSuccess extends SpeciesDetailState {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  SpeciesDetailSuccess({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}
