import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatisthis/theme/app_theme.dart';

class DictionaryCard extends StatelessWidget {
  final int dicId;
  final String imageUrl;
  final String name;
  final bool isDiscover;
  const DictionaryCard(
      {super.key,
      required this.dicId,
      required this.imageUrl,
      required this.name,
      this.isDiscover = false});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              width: double.infinity,
              height: double.infinity,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
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
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: isDiscover
                        ? AppTheme.lightTheme.colorScheme.primary.withAlpha(120)
                        : Colors.black.withAlpha(120),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(12))),
                child: Text(
                  isDiscover ? name : "미발견 - $name",
                  textAlign: TextAlign.center,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: isDiscover ? Colors.black : Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}
