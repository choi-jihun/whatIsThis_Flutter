import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatisthis/model/species.dart';
import 'package:whatisthis/theme/app_theme.dart';

class DictionaryCard extends StatelessWidget {
  final Species species;
  final bool isDiscovered;
  final VoidCallback? onTap;

  const DictionaryCard(
      {super.key,
      required this.species,
      this.isDiscovered = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  imageUrl: species.imageUrl ?? '',
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
                      color: isDiscovered
                          ? AppTheme.lightTheme.colorScheme.primary
                              .withAlpha(120)
                          : Colors.black.withAlpha(120),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(12))),
                  child: Text(
                    isDiscovered ? species.name : "미발견 - ${species.name}",
                    textAlign: TextAlign.center,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: isDiscovered ? Colors.black : Colors.white),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
