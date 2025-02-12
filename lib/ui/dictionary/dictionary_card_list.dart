import 'package:flutter/material.dart';
import 'package:whatisthis/model/species.dart';
import 'package:whatisthis/ui/dictionary/dictionary_info_page.dart';
import 'package:whatisthis/ui/dictionary_card.dart';

class DictionaryCardList extends StatelessWidget {
  final List<Species> species;
  final List<String> discoveredSpeciesIds;

  const DictionaryCardList({
    super.key,
    required this.species,
    required this.discoveredSpeciesIds,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
      itemCount: species.length,
      itemBuilder: (context, index) {
        final isDiscovered = discoveredSpeciesIds.contains(species[index].id);
        return DictionaryCard(
          species: species[index],
          isDiscovered: isDiscovered,
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DictionaryInfoPage(
                        speciesId: species[index].id,
                      ))),
        );
      },
    );
  }
}
