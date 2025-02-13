import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatisthis/di/providers.dart';
import 'package:whatisthis/state/home_state.dart';
import 'package:whatisthis/utils/check_permissions.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends AutoDisposeAsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() async {
    try {
      final position = await LocationService.getCurrentPosition();
      if (position == null) {
        return HomeError('위치 권한이 필요합니다');
      }

      final popularParks =
          await ref.read(parkRepositoryProvider).getPopularParks();
      final nearbyParks = await ref
          .read(parkRepositoryProvider)
          .getNearbyParks(position.latitude, position.longitude);

      for (var park in nearbyParks) {
        park.distance = Geolocator.distanceBetween(position.latitude,
            position.longitude, park.latitude, park.longitude);
      }

      final seasonalSpecies = await ref
          .read(speciesRepositoryProvider)
          .getSeasonalSpecies("WINTER");

      return HomeSuccess(
        popularParks: popularParks,
        nearbyParks: nearbyParks,
        seasonalSpecies: seasonalSpecies,
      );
    } catch (e) {
      return HomeError(e.toString());
    }
  }
}
