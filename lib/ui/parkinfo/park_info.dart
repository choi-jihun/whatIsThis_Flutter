import 'package:flutter/material.dart';
import 'package:whatisthis/cosntants/dummy_dictionary.dart';
import 'package:whatisthis/cosntants/dummy_park_info.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/dictionary/dictionary_info_page.dart';
import 'package:whatisthis/ui/dictionary_card.dart';
import 'package:whatisthis/ui/navermap/naver_map_page.dart';

class ParkInfo extends StatelessWidget {
  final int parkId;

  const ParkInfo({super.key, required this.parkId});

  @override
  Widget build(BuildContext context) {
    final parkInfo = dummyParkInfos.firstWhere((park) => park.parkId == parkId);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              floating: false,
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios)),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parkInfo.parkName,
                      style: AppTheme.lightTheme.textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '공원 소개',
                      style: AppTheme.lightTheme.textTheme.titleLarge,
                    ),
                    Divider(thickness: 1),
                    Text(
                      parkInfo.parkDes,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 24),
                    Text(
                      '관찰가능한 동식물',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Divider(thickness: 1),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return DictionaryCard(
                        dictionary: parkInfo.dictionaries[index],
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DictionaryInfoPage(
                                  dicId: dummyDics[index].dicId,
                                ),
                              ),
                            ));
                  },
                  childCount: parkInfo.dictionaries.length,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NaverMapPage(),
                )),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20), bottom: Radius.circular(0)),
              ),
            ),
            child: Text(
              '모험 시작하기',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
