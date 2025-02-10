import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatisthis/model/near_by_park.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/utils/format_distance.dart';

class ParkCard extends StatelessWidget {
  final NearbyPark park;
  final VoidCallback? onTap;

  const ParkCard({super.key, required this.park, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  imageUrl: park.imageUrl ?? '',
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(80),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      park.name,
                      style: AppTheme.lightTheme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          formatDistance(park.distance ?? 0),
                          style: AppTheme.lightTheme.textTheme.labelLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
