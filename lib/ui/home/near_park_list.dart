import 'package:flutter/material.dart';
import 'package:whatisthis/model/near_by_park.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/park_card.dart';
import 'package:whatisthis/ui/parkinfo/park_info.dart';
import 'package:whatisthis/ui/parklist/park_list.dart';

class NearParkList extends StatelessWidget {
  final List<NearbyPark> parks;

  const NearParkList({super.key, required this.parks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ParkList(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '가까운 공원',
                style: AppTheme.lightTheme.textTheme.headlineMedium,
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        const SizedBox(height: 4),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: parks.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return ParkCard(
              park: parks[index],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ParkInfo(parkId: parks[index].id),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
