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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dictionaryViewModelProvider.notifier).loadDictionaryData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dictionaryViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('도감',
                      style: AppTheme.lightTheme.textTheme.headlineLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${(state is DictionarySuccess ? state.discoveryRate * 100 : 0).toStringAsFixed(1)}%",
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value:
                          state is DictionarySuccess ? state.discoveryRate : 0,
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.green,
                      minHeight: 8,
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
                  child: switch (state) {
                    DictionaryLoading() =>
                      const Center(child: CircularProgressIndicator()),
                    DictionaryError(message: var message) =>
                      Center(child: Text(message)),
                    DictionarySuccess(
                      species: var species,
                      discoveredSpeciesIds: var discoveredIds
                    ) =>
                      DictionaryCardList(
                        species: switch (selectedFilter) {
                          'discover' => species
                              .where((s) => discoveredIds.contains(s.id))
                              .toList(),
                          'undiscover' => species
                              .where((s) => !discoveredIds.contains(s.id))
                              .toList(),
                          _ => species,
                        },
                        discoveredSpeciesIds: discoveredIds,
                      ),
                    _ => const SizedBox(),
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
