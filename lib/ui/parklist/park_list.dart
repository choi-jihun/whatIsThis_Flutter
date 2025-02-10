import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatisthis/state/home_state.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/park_card.dart';
import 'package:whatisthis/ui/parkinfo/park_info.dart';
import 'package:whatisthis/viewmodel/home_view_model.dart';

class ParkList extends ConsumerWidget {
  const ParkList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text(
          '공원 목록',
          style: AppTheme.lightTheme.textTheme.headlineLarge,
        ),
        elevation: 8,
      ),
      body: switch (homeState) {
        HomeInitial() ||
        HomeLoading() =>
          const Center(child: CircularProgressIndicator()),
        HomeError(message: var message) => Center(child: Text(message)),
        HomeSuccess(nearbyParks: var parks) => ListView.separated(
            padding: const EdgeInsets.all(12),
            shrinkWrap: true,
            itemCount: parks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return ParkCard(
                park: parks[index],
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ParkInfo(parkId: parks[index].id))),
              );
            },
          ),
      },
    );
  }
}
