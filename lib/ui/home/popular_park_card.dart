import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatisthis/theme/app_theme.dart';

class PopularParkCard extends StatelessWidget {
  final int parkId;
  final String imageUrl;
  final String parkName;
  final String parkDes;
  const PopularParkCard(
      {super.key,
      required this.parkId,
      required this.parkName,
      required this.imageUrl,
      required this.parkDes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 150,
            width: 220,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Text(
            parkName,
            style: AppTheme.lightTheme.textTheme.bodyLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            parkDes,
            style: AppTheme.lightTheme.textTheme.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
