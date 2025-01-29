import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatisthis/ui/camera/camera.dart';
import 'package:whatisthis/ui/confirm_dialog.dart';
import 'package:whatisthis/ui/dictionary/dictionary_page.dart';
import 'package:whatisthis/ui/map_button.dart';
import 'package:whatisthis/ui/mission_dialog.dart';

class NaverMapPage extends StatelessWidget {
  const NaverMapPage({super.key});

  Future<void> _checkPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      print("위치 권한 허용됨");
    } else if (status.isDenied) {
      print("위치 권한 거부됨");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            NaverMap(
              options: const NaverMapViewOptions(locationButtonEnable: true),
              onMapReady: (controller) async {
                await _checkPermission();
                controller
                    .setLocationTrackingMode(NLocationTrackingMode.follow);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MapButton(
                          onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const ConfirmDialog(),
                          ),
                          text: '탐험 끝내기',
                          backgroundColor: Colors.green[600],
                          isLeftRadius: false,
                        ),
                        MapButton(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DictionaryPage(), //TODO 추후에 parkId 혹은 adventureId 보내기
                            ),
                          ),
                          text: '도감',
                          icon: Icons.book,
                          isRightRadius: false,
                        ),
                      ]),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MapButton(
                        onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => MissionDialog()),
                        text: '도전과제',
                        icon: Icons.question_mark_sharp,
                        isRightRadius: false,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green[600],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16)),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Camera(),
                          ));
                    },
                    icon: const Icon(Icons.center_focus_weak),
                    iconSize: 42,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
