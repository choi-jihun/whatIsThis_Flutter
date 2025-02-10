import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatisthis/theme/app_theme.dart';

class CircleImageWithText extends StatelessWidget {
  final String itemId;
  final String imageUrl;
  final String name;

  const CircleImageWithText(
      {super.key,
      required this.itemId,
      required this.imageUrl,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          name,
          style: AppTheme.lightTheme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
