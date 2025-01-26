import 'package:whatisthis/model/dictionary.dart';

class ParkInfo {
  final int parkId;
  final String imageUrl;
  final String parkName;
  final String parkDes;
  final List<Dictionary> dictionaries;

  ParkInfo(
      {required this.parkId,
      required this.imageUrl,
      required this.parkName,
      required this.parkDes,
      required this.dictionaries});
}
