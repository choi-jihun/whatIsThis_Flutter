import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:whatisthis/di/providers.dart';
import 'package:whatisthis/repository/park_repository.dart';
import 'package:whatisthis/repository/species_repository.dart';
import 'package:whatisthis/state/home_state.dart';
import 'package:whatisthis/utils/check_permissions.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(
    ref.watch(parkRepositoryProvider),
    ref.watch(speciesRepositoryProvider),
  );
});

class HomeViewModel extends StateNotifier<HomeState> {
  final ParkRepository _parkRepository;
  final SpeciesRepository _speciesRepository;

  HomeViewModel(this._parkRepository, this._speciesRepository)
      : super(HomeInitial());

  Future<void> loadHomeData() async {
    state = HomeLoading();
    try {
      final position = await LocationService.getCurrentPosition();
      if (position == null) {
        state = HomeError('위치 권한이 필요합니다');
        return;
      }

      final popularParks = await _parkRepository.getPopularParks();
      final nearbyParks = await _parkRepository.getNearbyParks(
          position.latitude, position.longitude);

      for (var park in nearbyParks) {
        park.distance = Geolocator.distanceBetween(position.latitude,
            position.longitude, park.latitude, park.longitude);
      }
      final seasonalSpecies =
          await _speciesRepository.getSeasonalSpecies("WINTER");

      state = HomeSuccess(
        popularParks: popularParks,
        nearbyParks: nearbyParks,
        seasonalSpecies: seasonalSpecies,
      );
    } catch (e) {
      state = HomeError(e.toString());
    }
  }
}
