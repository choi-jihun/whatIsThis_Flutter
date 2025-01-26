import 'package:flutter/material.dart';
import 'package:whatisthis/model/dictionary.dart';
import 'package:whatisthis/ui/dictionary_card.dart';

class DictionaryCardList extends StatelessWidget {
  DictionaryCardList({super.key});

  final List<Dictionary> dummyDics = [
    Dictionary(
      dicId: 1,
      dicName: '서울숲',
      isDiscover: true,
      imageUrl:
          'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
    ),
    Dictionary(
      dicId: 2,
      dicName: 'heart',
      isDiscover: false,
      imageUrl:
          'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
    ),
    Dictionary(
      dicId: 3,
      dicName: '히히히',
      isDiscover: true,
      imageUrl:
          'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
    ),
    Dictionary(
      dicId: 4,
      dicName: '뭘까요',
      isDiscover: true,
      imageUrl:
          'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
    ),
    Dictionary(
      dicId: 5,
      dicName: '능소화',
      isDiscover: false,
      imageUrl:
          'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
      itemCount: dummyDics.length,
      itemBuilder: (context, index) {
        return DictionaryCard(
          dicId: dummyDics[index].dicId,
          imageUrl: dummyDics[index].imageUrl,
          name: dummyDics[index].dicName,
          isDiscover: dummyDics[index].isDiscover,
        );
      },
    );
  }
}
