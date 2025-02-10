import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatisthis/model/location.dart';
import 'package:whatisthis/model/near_by_park.dart';
import 'package:whatisthis/model/popular_park.dart';
import 'package:whatisthis/repository/auth_repository.dart';
import 'package:whatisthis/repository/park_repository.dart';
import 'package:whatisthis/repository/species_repository.dart';
import 'package:whatisthis/repositoryimpl/auth_repository_impl.dart';
import 'package:whatisthis/repositoryimpl/park_repository_impl.dart';
import 'package:whatisthis/repositoryimpl/species_repository_impl.dart';

// Supabase Client Provider
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// Repository Providers
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(supabaseClientProvider));
});

final parkRepositoryProvider = Provider<ParkRepository>((ref) {
  return ParkRepositoryImpl(ref.watch(supabaseClientProvider));
});

// Data Providers
final popularParksProvider = FutureProvider<List<PopularPark>>((ref) {
  return ref.watch(parkRepositoryProvider).getPopularParks();
});

final nearbyParksProvider =
    FutureProvider.family<List<NearbyPark>, Location>((ref, location) {
  return ref.watch(parkRepositoryProvider).getNearbyParks(
        location.latitude,
        location.longitude,
      );
});

final speciesRepositoryProvider = Provider<SpeciesRepository>((ref) {
  return SpeciesRepositoryImpl(ref.watch(supabaseClientProvider));
});
