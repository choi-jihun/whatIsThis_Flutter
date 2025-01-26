import 'package:flutter/material.dart';
import 'package:whatisthis/model/popular_park.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/home/popular_park_card.dart';
import 'package:whatisthis/ui/parkinfo/park_info.dart';

class PopularParkList extends StatelessWidget {
  PopularParkList({super.key});

  final List<PopularPark> dummyParks = [
    PopularPark(
      parkId: 1,
      parkName: '서울숲',
      parkDes: '도심 속 생태공원',
      imageUrl:
          'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
    ),
    PopularPark(
      parkId: 2,
      parkName: '올림픽공원',
      parkDes: '자연과 문화가 어우러진 공원으로 놀러오세요 ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ',
      imageUrl:
          'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
    ),
    PopularPark(
      parkId: 3,
      parkName: '올림픽공원',
      parkDes: '자연과 문화가 어우러진 공원',
      imageUrl: 'https://example.com/olympic-park.jpg',
    ),
    PopularPark(
      parkId: 4,
      parkName: '올림픽공원',
      parkDes: '자연과 문화가 어우러진 공원',
      imageUrl: 'https://example.com/olympic-park.jpg',
    ),
    PopularPark(
      parkId: 5,
      parkName: '올림픽공원',
      parkDes: '자연과 문화가 어우러진 공원',
      imageUrl: 'https://example.com/olympic-park.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '인기공원',
          style: AppTheme.lightTheme.textTheme.headlineMedium,
        ),
        SizedBox(
            height: 220,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dummyParks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: PopularParkCard(
                      parkId: dummyParks[index].parkId,
                      parkName: dummyParks[index].parkName,
                      parkDes: dummyParks[index].parkDes,
                      imageUrl: dummyParks[index].imageUrl,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ParkInfo(parkId: dummyParks[index].parkId))),
                    ),
                  );
                })),
      ],
    );
  }
}
