import 'package:flutter/material.dart';
import 'package:whatisthis/model/near_park.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/park_card.dart';

class NearParkList extends StatelessWidget {
  NearParkList({super.key});

  final List<NearPark> dummyParks = [
    NearPark(
        parkId: 1,
        parkName: '서울숲',
        imageUrl:
            'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
        distance: 765),
    NearPark(
        parkId: 2,
        parkName: '올림픽공원',
        imageUrl: 'https://example.com/park2.jpg',
        distance: 990),
    NearPark(
        parkId: 3,
        parkName: '북서울꿈의숲',
        imageUrl: 'https://example.com/park3.jpg',
        distance: 1200),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '가까운 공원',
              style: AppTheme.lightTheme.textTheme.headlineMedium,
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
        SizedBox(
          height: 4,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return ParkCard(
              imageUrl: dummyParks[index].imageUrl,
              parkName: dummyParks[index].parkName,
              distance: dummyParks[index].distance,
            );
          },
        ),
        SizedBox(
          height: 12,
        )
      ],
    );
  }
}
