import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatisthis/state/home_state.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/home/near_park_list.dart';
import 'package:whatisthis/ui/home/popular_park_list.dart';
import 'package:whatisthis/ui/home/season_list.dart';
import 'package:whatisthis/viewmodel/home_view_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).loadHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: _buildContent(homeState),
      ),
    );
  }

  Widget _buildContent(HomeState state) {
    return switch (state) {
      HomeInitial() => const Center(child: CircularProgressIndicator()),
      HomeLoading() => const Center(child: CircularProgressIndicator()),
      HomeError(message: var message) => Center(child: Text(message)),
      HomeSuccess(
        popularParks: var popularParks,
        nearbyParks: var nearbyParks,
        seasonalSpecies: var seasonalSpecies,
      ) =>
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Collapsing 영역',
                        style: AppTheme.lightTheme.textTheme.headlineMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: PopularParkList(parks: popularParks),
                  ),
                  SizedBox(
                    height: 8,
                    width: MediaQuery.of(context).size.width,
                    child: ColoredBox(color: Colors.grey.shade300),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: NearParkList(parks: nearbyParks),
                  ),
                  SizedBox(
                    height: 8,
                    width: MediaQuery.of(context).size.width,
                    child: ColoredBox(color: Colors.grey.shade300),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SeasonList(species: seasonalSpecies),
                  ),
                ],
              ),
            ),
          ],
        ),
    };
  }
}
