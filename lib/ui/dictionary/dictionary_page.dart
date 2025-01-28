import 'package:flutter/material.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/dictionary/dictionary_card_list.dart';

class DictionaryPage extends StatefulWidget {
  final int? parkId;
  const DictionaryPage({super.key, this.parkId});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  String selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    '도감',
                    style: AppTheme.lightTheme.textTheme.headlineLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "60%",
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: 0.6,
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
                            ? Icon(
                                Icons.check_circle_outline,
                                size: 18,
                                color: Colors.white,
                              )
                            : null,
                        backgroundColor: Colors.white,
                        selectedColor: Colors.black,
                        labelStyle: TextStyle(
                            color: selectedFilter == 'all'
                                ? Colors.white
                                : Colors.black,
                            fontSize: 14),
                        onSelected: (_) =>
                            setState(() => selectedFilter = 'all'),
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
                child: DictionaryCardList(
                  parkId: widget.parkId,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
