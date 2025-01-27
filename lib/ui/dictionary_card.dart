import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatisthis/model/dictionary.dart';
import 'package:whatisthis/theme/app_theme.dart';

class DictionaryCard extends StatelessWidget {
  final Dictionary dictionary;
  final VoidCallback? onTap;
  const DictionaryCard({super.key, required this.dictionary, this.onTap});

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
                  imageUrl: dictionary.imageUrl,
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
                      color: dictionary.isDiscover
                          ? AppTheme.lightTheme.colorScheme.primary
                              .withAlpha(120)
                          : Colors.black.withAlpha(120),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(12))),
                  child: Text(
                    dictionary.isDiscover
                        ? dictionary.dicName
                        : "미발견 - ${dictionary.dicName}",
                    textAlign: TextAlign.center,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: dictionary.isDiscover
                            ? Colors.black
                            : Colors.white),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
