import 'package:flutter/material.dart';
import 'package:whatisthis/model/season_item.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/circle_image_with_text.dart';

class SeasonList extends StatelessWidget {
  SeasonList({super.key});

  final List<SeasonItem> dummyItems = [
    SeasonItem(
        itemId: 1,
        imageUrl:
            'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
        itemName: "수선화"),
    SeasonItem(
        itemId: 2,
        imageUrl:
            'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
        itemName: "능소화"),
    SeasonItem(
        itemId: 3,
        imageUrl:
            'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
        itemName: "무엇?"),
    SeasonItem(
        itemId: 4,
        imageUrl:
            'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
        itemName: "무슨꽃"),
    SeasonItem(
        itemId: 5,
        imageUrl:
            'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
        itemName: "다람쥐"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '겨울엔 이걸 찾아보아요',
          style: AppTheme.lightTheme.textTheme.headlineMedium,
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dummyItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: CircleImageWithText(
                      itemId: dummyItems[index].itemId,
                      imageUrl: dummyItems[index].imageUrl,
                      name: dummyItems[index].itemName),
                );
              }),
        )
      ],
    );
  }
}
