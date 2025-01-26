import 'package:flutter/material.dart';
import 'package:whatisthis/cosntants/dummy_park.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/park_card.dart';
import 'package:whatisthis/ui/parkinfo/park_info.dart';
import 'package:whatisthis/ui/parklist/park_list.dart';

class NearParkList extends StatelessWidget {
  const NearParkList({super.key});

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
                ));
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
              park: dummyParks[index],
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ParkInfo(parkId: dummyParks[index].parkId))),
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
