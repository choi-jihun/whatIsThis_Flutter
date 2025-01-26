import 'package:flutter/material.dart';
import 'package:whatisthis/model/adventure.dart';
import 'package:whatisthis/ui/adventure/adventure_card.dart';

final List<Adventure> dummyAdventures = [
  Adventure(
    1,
    'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
    '서울숲',
    DateTime(2024, 1, 15, 14, 30),
    2500,
    5,
    120,
    3,
  ),
  Adventure(
    2,
    'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
    '올림픽공원',
    DateTime(2024, 1, 14, 10, 0),
    3800,
    8,
    180,
    5,
  ),
  Adventure(
    3,
    'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
    '북서울꿈의숲',
    DateTime(2024, 1, 13, 15, 45),
    1800,
    3,
    90,
    2,
  ),
  Adventure(
    4,
    'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
    '남산공원',
    DateTime(2024, 1, 12, 13, 20),
    4200,
    6,
    150,
    4,
  ),
  Adventure(
    5,
    'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
    '보라매공원',
    DateTime(2024, 1, 11, 16, 15),
    2900,
    4,
    100,
    3,
  ),
];

class AdventurePage extends StatefulWidget {
  const AdventurePage({super.key});

  @override
  State<AdventurePage> createState() => _AdventurePageState();
}

class _AdventurePageState extends State<AdventurePage> {
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );
  double _currentPageValue = 0.0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '사용자님의 탐험일지',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: dummyAdventures.length,
                itemBuilder: (context, index) {
                  double diff = (index - _currentPageValue);
                  double scale = 1 - (diff.abs() * 0.1);
                  scale = scale.clamp(0.9, 1.0);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Transform(
                      transform: Matrix4.identity()..scale(scale, scale),
                      alignment: Alignment.center,
                      child: AdventureCard(
                        cardId: dummyAdventures[index].adventureId,
                        imageUrl: dummyAdventures[index].imageUrl,
                        parkName: dummyAdventures[index].parkName,
                        date: dummyAdventures[index].date,
                        distance: dummyAdventures[index].distance,
                        register: dummyAdventures[index].register,
                        spendTime: dummyAdventures[index].spendTime,
                        successMission: dummyAdventures[index].successMission,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                '${_currentPage + 1}/${dummyAdventures.length}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
