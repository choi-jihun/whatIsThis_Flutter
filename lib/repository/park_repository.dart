import 'package:whatisthis/model/near_by_park.dart';
import 'package:whatisthis/model/popular_park.dart';

abstract class ParkRepository {
  Future<List<PopularPark>> getPopularParks();
  Future<List<NearbyPark>> getNearbyParks(double lat, double lng);
}
