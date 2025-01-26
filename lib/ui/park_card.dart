import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/utils/format_distance.dart';

class ParkCard extends StatelessWidget {
  final String imageUrl;
  final String parkName;
  final int distance;
  const ParkCard(
      {super.key,
      required this.imageUrl,
      required this.parkName,
      required this.distance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            blurRadius: 4,
          )
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 180,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.black.withAlpha(80),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        parkName,
                        style: AppTheme.lightTheme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            formatDistance(distance),
                            style: AppTheme.lightTheme.textTheme.labelLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ))),
        ],
      ),
    );
  }
}
