import 'package:whatisthis/model/near_by_park.dart';
import 'package:whatisthis/model/popular_park.dart';
import 'package:whatisthis/model/species.dart';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class HomeSuccess extends HomeState {
  final List<PopularPark> popularParks;
  final List<NearbyPark> nearbyParks;
  final List<Species> seasonalSpecies;

  HomeSuccess({
    required this.popularParks,
    required this.nearbyParks,
    required this.seasonalSpecies,
  });
}
