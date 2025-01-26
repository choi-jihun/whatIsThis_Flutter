import 'package:flutter/material.dart';
import 'package:whatisthis/cosntants/dummy_park.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/park_card.dart';
import 'package:whatisthis/ui/parkinfo/park_info.dart';

class ParkList extends StatelessWidget {
  const ParkList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text(
          '공원 목록',
          style: AppTheme.lightTheme.textTheme.headlineLarge,
        ),
        elevation: 8,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        shrinkWrap: true,
        itemCount: dummyParks.length,
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
    );
  }
}
