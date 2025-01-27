import 'package:flutter/material.dart';
import 'package:whatisthis/cosntants/dummy_dictionary.dart';
import 'package:whatisthis/ui/dictionary/dictionary_info_page.dart';
import 'package:whatisthis/ui/dictionary_card.dart';

class DictionaryCardList extends StatelessWidget {
  final int? parkId;
  const DictionaryCardList({super.key, this.parkId});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
      itemCount: dummyDics.length,
      itemBuilder: (context, index) {
        return DictionaryCard(
          dictionary: dummyDics[index],
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DictionaryInfoPage(
                        dicId: dummyDics[index].dicId,
                      ))),
        );
      },
    );
  }
}
