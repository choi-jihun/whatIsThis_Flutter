import 'package:flutter/material.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/custom_mission.dart';

class MissionDialog extends StatelessWidget {
  const MissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF9E6240),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.4,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    '도전과제',
                    style:
                        AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                      color: Color(0xFFFFF1D6),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.25,
                        child: CustomMission(
                          isSuccess: true,
                          missionText: '수달에게 솔방울 선물하기',
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.25,
                        child: CustomMission(
                          isSuccess: false,
                          missionText: '참새에게 은행잎 선물하기',
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.25,
                        child: CustomMission(
                          isSuccess: true,
                          missionText: '거북이에게 단풍잎 선물하기',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
