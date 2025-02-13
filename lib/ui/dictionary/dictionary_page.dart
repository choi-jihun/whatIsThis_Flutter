import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatisthis/state/dictionary_state.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/dictionary/dictionary_card_list.dart';
import 'package:whatisthis/viewmodel/dictionary_view_model.dart';

class DictionaryPage extends ConsumerStatefulWidget {
  final String? parkId;
  const DictionaryPage({super.key, this.parkId});

  @override
  ConsumerState<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends ConsumerState<DictionaryPage> {
  String selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dictionaryViewModelProvider);

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('도감',
                      style: AppTheme.lightTheme.textTheme.headlineLarge),
                  state.when(
                    loading: () => const Text("..."),
                    error: (error, stack) => const Text("0.0%"),
                    data: (dictionaryState) => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (dictionaryState is DictionarySuccess)
                          Text(
                            "${(dictionaryState.discoveryRate * 100).toStringAsFixed(1)}%",
                            style: AppTheme.lightTheme.textTheme.bodyMedium,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: state.when(
                      loading: () => LinearProgressIndicator(
                        value: 0,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.green,
                        minHeight: 8,
                      ),
                      error: (error, stack) => LinearProgressIndicator(
                        value: 0,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.green,
                        minHeight: 8,
                      ),
                      data: (dictionaryState) => LinearProgressIndicator(
                        value: dictionaryState is DictionarySuccess
                            ? dictionaryState.discoveryRate
                            : 0,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.green,
                        minHeight: 8,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 8.0,
                    children: [
                      FilterChip(
                        shape: StadiumBorder(),
                        label: const Text('전체'),
                        selected: selectedFilter == 'all',
                        showCheckmark: false,
                        avatar: selectedFilter == 'all'
                            ? Icon(Icons.check_circle_outline,
                                size: 18, color: Colors.white)
                            : null,
                        backgroundColor: Colors.white,
                        selectedColor: Colors.black,
                        labelStyle: TextStyle(
                            color: selectedFilter == 'all'
                                ? Colors.white
                                : Colors.black,
                            fontSize: 14),
                        onSelected: (_) {
                          setState(() => selectedFilter = 'all');
                        },
                      ),
                      FilterChip(
                        shape: StadiumBorder(),
                        label: const Text('발견'),
                        selected: selectedFilter == 'discover',
                        showCheckmark: false,
                        avatar: selectedFilter == 'discover'
                            ? Icon(
                                Icons.check_circle_outline,
                                size: 18,
                                color: Colors.white,
                              )
                            : null,
                        backgroundColor: Colors.white,
                        selectedColor: Colors.black,
                        labelStyle: TextStyle(
                            color: selectedFilter == 'discover'
                                ? Colors.white
                                : Colors.black,
                            fontSize: 14),
                        onSelected: (_) =>
                            setState(() => selectedFilter = 'discover'),
                      ),
                      FilterChip(
                        shape: StadiumBorder(),
                        label: const Text('미발견'),
                        selected: selectedFilter == 'undiscover',
                        showCheckmark: false,
                        avatar: selectedFilter == 'undiscover'
                            ? Icon(
                                Icons.check_circle_outline,
                                size: 18,
                                color: Colors.white,
                              )
                            : null,
                        backgroundColor: Colors.white,
                        selectedColor: Colors.black,
                        labelStyle: TextStyle(
                            color: selectedFilter == 'undiscover'
                                ? Colors.white
                                : Colors.black,
                            fontSize: 14),
                        onSelected: (_) =>
                            setState(() => selectedFilter = 'undiscover'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: state.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) =>
                      Center(child: Text(error.toString())),
                  data: (dictionaryState) {
                    if (dictionaryState is DictionarySuccess) {
                      return DictionaryCardList(
                        species: switch (selectedFilter) {
                          'discover' => dictionaryState.species
                              .where((s) => dictionaryState.discoveredSpeciesIds
                                  .contains(s.id))
                              .toList(),
                          'undiscover' => dictionaryState.species
                              .where((s) => !dictionaryState
                                  .discoveredSpeciesIds
                                  .contains(s.id))
                              .toList(),
                          _ => dictionaryState.species,
                        },
                        discoveredSpeciesIds:
                            dictionaryState.discoveredSpeciesIds,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
