import 'package:flutter/material.dart';
import 'package:whatisthis/model/species.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/circle_image_with_text.dart';

class SeasonList extends StatelessWidget {
  final List<Species> species;

  const SeasonList({super.key, required this.species});

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
            itemCount: species.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CircleImageWithText(
                  itemId: species[index].id,
                  imageUrl: species[index].imageUrl ?? '',
                  name: species[index].name,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
