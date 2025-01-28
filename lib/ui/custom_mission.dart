import 'package:flutter/material.dart';
import 'package:whatisthis/theme/app_theme.dart';

class CustomMission extends StatelessWidget {
  final bool isSuccess;
  final String missionText;
  const CustomMission(
      {super.key, this.isSuccess = false, required this.missionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isSuccess
              ? Icon(
                  Icons.star_border,
                  color: Color(0xFFFFBC10),
                )
              : Icon(
                  Icons.star,
                  color: Color(0xFFFFBC10),
                ),
          Text(
            missionText,
            style: AppTheme.lightTheme.textTheme.bodyLarge
                ?.copyWith(color: Color(0xFF9E6240)),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward, color: Color(0xFF9E6240)))
        ],
      ),
    );
  }
}
