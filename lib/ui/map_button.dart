import 'package:flutter/material.dart';
import 'package:whatisthis/theme/app_theme.dart';

class MapButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final String text;
  final Color? backgroundColor;
  final double width;
  final bool isLeftRadius;
  final bool isRightRadius;

  const MapButton({
    super.key,
    this.onTap,
    this.icon,
    this.backgroundColor,
    this.width = 120,
    this.isLeftRadius = true,
    this.isRightRadius = true,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? const Color(0xFF8B4513),
      borderRadius: BorderRadius.horizontal(
        left: isLeftRadius ? const Radius.circular(6) : Radius.zero,
        right: isRightRadius ? const Radius.circular(6) : Radius.zero,
      ),
      child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.horizontal(
            left: isLeftRadius ? const Radius.circular(6) : Radius.zero,
            right: isRightRadius ? const Radius.circular(6) : Radius.zero,
          ),
          child: Container(
            width: width,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 4),
                ],
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: AppTheme.lightTheme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
