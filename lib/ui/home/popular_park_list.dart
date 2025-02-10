import 'package:flutter/material.dart';
import 'package:whatisthis/model/popular_park.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/home/popular_park_card.dart';
import 'package:whatisthis/ui/parkinfo/park_info.dart';

class PopularParkList extends StatelessWidget {
  final List<PopularPark> parks;

  const PopularParkList({super.key, required this.parks});

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
            itemCount: parks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: PopularParkCard(
                  parkId: parks[index].id,
                  parkName: parks[index].name,
                  parkDes: parks[index].description,
                  imageUrl: parks[index].imageUrl ?? '',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParkInfo(parkId: parks[index].id),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
