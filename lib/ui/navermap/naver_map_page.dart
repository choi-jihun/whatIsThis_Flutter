import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:permission_handler/permission_handler.dart';

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
        body: NaverMap(
          options: const NaverMapViewOptions(locationButtonEnable: true),
          onMapReady: (controller) async {
            await _checkPermission();
            controller.setLocationTrackingMode(NLocationTrackingMode.follow);
          },
        ),
      ),
    );
  }
}
